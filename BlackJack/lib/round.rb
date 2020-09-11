# frozen_string_literal: true
require 'io/console' # (для использования STDIN.getch вместо gets)

class Round
  UNKNOWN_COMMAND       = 'Неизвестная команда!'.freeze
  BETS                  = 10
  PRESS_KEY_BLINK       = "\nДля продолжения нажмите пробел или Enter.. \033[1;5m_\033[0;25m\n".freeze

  attr_reader :name, :deck, :open, :interface, :logic, :skip_player
  attr_accessor :bank_game, :players

  def initialize
    @logic  = Logic.new(self)
    @interface  = Interface.new(self)
    @bank = 0 # @bank -> user
    @bank_game = 0 
    @skip_player = 0 
    @players = []
    @open = false
    prepare_round
  end

  def prepare_round
    inputs_name
    create_users(name)
  end

  def inputs_name
    system 'clear'
    print 'Пожалуйста, введите свое имя ... ' # blink
    @name = gets.chomp # puts "Создан игрок - #{name}" 
    system 'clear'
  end

  def create_users(name)
    player = Player.new(name)
    diler = Player.new # генерировать имя? 
    players << diler << player
  end

  def start_round
    players.each(&:clear_hands)
    @deck = Deck.new 
    login_user
    play_game
  end

  def login_user
    @open = false
    players.each do |player|
      2.times { player.get_card(@deck.pop!) }
      @bank += player.give_money(BETS)
      @bank_game += BETS
    end
  end

  def play_game
    loop do
      break if three_cards?

      interface.table_summary(players, :close)
      input = interface.play_menu
      case input
      # when 0
      #   break
      when 1
        skip_step
      when 2
        add_card(:player)
      when 3
        @open = true
        break
      else
        puts UNKNOWN_COMMAND
      end
    end
    end_round
  end
 
  def skip_step
    raise "Пропустить ход можете только один раз!" unless skip_player.zero?         

    @skip_player += 1
    system 'clear'
    puts 'Противник принял решение! Ход за Вами...'
    logic.diler_step(players)
  rescue StandardError => e
    puts "Возникла ошибка: #{e.message}"
    press_key
  end

  def add_card(player)
    raise "на руках уже 3 карты!" if players_three_cards?
   
    player == :diler ? players[0].get_card(@deck.pop!) : players[1].get_card(@deck.pop!)
    system 'clear'
  rescue StandardError => e
    puts "Возникла ошибка: #{e.message}"
    press_key
    system 'clear'
  end

  def players_three_cards?
    players[1].hand.cards.size >= 3
  end  

  def three_cards?
    players[0].hand.cards.size >= 3 && players[1].hand.cards.size >= 3
  end

  def show_bank
    puts "Ставки игры: $#{@bank_game}"
    puts '-'*16
    puts
  end

  def end_round
    @bank_game = 0 
    @skip_player = 0
    logic.choose_winner(players)
    interface.table_summary(players, :open)
    puts "\nУ #{players.last.name} на счету: $#{players.last.bank}"
    puts 
    print "Хотите начать новую игру? (y/*)  "
    start_round if gets.chomp.strip.downcase == 'y'
    system 'clear'
  end
  
  # proxy method
  def show_winner(player)
    system 'clear'
    puts "Игра окончена..."
    interface.show_winner(player)
  end
  
  def press_key
    printf PRESS_KEY_BLINK
    loop do
      break if [' ', "\r"].include?(STDIN.getch)
    end
    system 'clear'
  end
end
