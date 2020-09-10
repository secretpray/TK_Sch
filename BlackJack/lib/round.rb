# frozen_string_literal: true

class Round

  BETS = 10

  attr_reader :name, :deck, :open, :interface
  attr_accessor :bank_game, :players

  def initialize
    @interface  = Interface.new(self)
    @bank = 0
    @bank_game = 0
    @players = []
    @open = false
    prepare_round
  end

  def prepare_round
    # interface.start_menu
    inputs_name
    create_users(name)
  end

  def game_run
    start_round
    end_round
  end

  def start_round
    players.each(&:clear_hands)
    make_deck 
    login_user
    interface.table_summary(players, :close)
    play_game
  end

  def play_game
    loop do
      break if break_conditions

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
        open_card  
      else
        puts 'Неизвестная команда'  
      end
    end
  end
 
  def break_conditions
    false
      # player_step(@player)
      # player_step(@diller)
      three_cards? || @open
  end

  def three_cards?
    players.select { |p| p.cards_count == 3 }.size == 2
  end

  def end_round
    # result_round
    # статистика (при наличии времени)
    print "У #{players.last.name} на счету осталось: #{players.last.bank} $. Хотите начать новую игру? (y/*)  "
    game_run if gets.chomp.downcase == 'y'
  end
  
  def inputs_name
    system 'clear'
    print 'Пожалуйста, введите свое имя ... ' # blink
    @name = gets.chomp # puts "Создан игрок - #{name}" 
    # validate name (w and d only; 1 - 20 letters)
  end

  def create_users(name)
    player = Player.new(name)
    diler = Player.new # можно сгенерировать имя... 
    players << diler << player
  end

  def login_user
    @players.each do |player|
      2.times { player.get_card(@deck.pop!) }
      @bank += player.give_money(BETS)
      @bank_game += BETS
    end
  end
  
  def show_bank
    system 'clear'
    puts "Банк: $#{@bank_game}"
    puts '-'*9
  end

  def make_deck
    @deck = Deck.new
  end
end
