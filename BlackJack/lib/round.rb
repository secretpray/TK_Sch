# frozen_string_literal: true
require 'io/console' # (для использования STDIN.getch вместо gets)

class Round
  UNKNOWN_COMMAND       = 'Неизвестная команда!'.freeze
  BETS                  = 10
  PRESS_KEY_BLINK       = "\nДля продолжения нажмите пробел или Enter.. \033[1;5m_\033[0;25m".freeze

  attr_reader :name, :deck, :open, :interface, :logic
  attr_accessor :bank_game, :players

  def initialize
    @interface  = Interface.new(self)
    @logic  = Logic.new(self)
    @bank = 0 # user
    @bank_game = 0
    @players = []
    @open = false
    prepare_round
  end

  def prepare_round
    inputs_name
    create_users(name)
  end

  def start_round
    players.each(&:clear_hands)
    make_deck 
    login_user
    play_game
  end

  def play_game
    loop do
      interface.table_summary(players, :close)
      
      input = interface.play_menu
      case input
      when 0
        break
      when 1
        skip_step
      when 2
        add_card
      when 3
        @open = true
        break
      else
        puts UNKNOWN_COMMAND
      end
    end
    end_round
  end
 
  def three_cards?
    players[0].hand.cards.size >= 3 || players[1].hand.cards.size >= 3
  end

  def end_round
    @bank_game = 0
    logic.choose_winner(players)
    interface.table_summary(players, :open)
    puts "\nУ #{players.last.name} на счету осталось: $#{players.last.bank}"
    puts 
    print "Хотите начать новую игру? (y/*)  "
    start_round if gets.chomp.downcase == 'y'
  end
  
  def inputs_name
    system 'clear'
    print 'Пожалуйста, введите свое имя ... ' # blink
    @name = gets.chomp # puts "Создан игрок - #{name}" 
    system 'clear'
  end

  def show_winner(player)
    system 'clear'
    puts "Игра окончена..."
    interface.show_winner(player)
  end
    
  def create_users(name)
    player = Player.new(name)
    diler = Player.new # генерировать имя? 
    players << diler << player
  end

  def login_user
    @open = false
    players.each do |player|
      2.times { player.get_card(@deck.pop!) }
      @bank += player.give_money(BETS)
      @bank_game += BETS
    end
  end
  
  def show_bank
    puts "Банк casino: $#{@bank_game}"
    puts '-'*16
    puts
  end

  def make_deck
    @deck = Deck.new
  end

  def add_card
    raise "на руках уже 3 карты!" if three_cards?
   
    players.last.get_card(@deck.pop!)
  rescue StandardError => e
    puts "Возникла ошибка: #{e.message}"
    press_key
  end

  def press_key
    printf PRESS_KEY_BLINK
    loop do
      break if [' ', "\r"].include?(STDIN.getch)
    end
  end
end
