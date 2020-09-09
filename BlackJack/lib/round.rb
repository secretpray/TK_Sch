# frozen_string_literal: true
require_relative 'interface'
require_relative 'player'
require_relative 'hand'
require_relative 'card'
require_relative 'deck'
require_relative 'validation'



class Round
  include Validation #(проверка 3 карты, перебор, очередность и правильность выбора)

  BETS = 10

  attr_reader :name, :deck
  attr_accessor :bank, :players


  def initialize
    @interface  = Interface.new
    @bank = 0
    @players = []
    prepare_round
  end

  def prepare_round
    # start_menu
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
    puts 'Играем...'
    login_user
    # loop 
    # login_user + bet
    # interface_menu_statistic (players, bank, show cards - hide/unhide)
    
    # game_menu for player (add cards, skip, show cards)
    # обработка ходов (стоит ли добавлять class with logic_game) и выход по 3 картам, перебору, открытию карт
    # loop end
    puts 'Получаем результат...'
  end

  def end_round
    # result_round
    # статистика (при наличии времени)
    print "У #{players.last.name} на счету осталось: #{players.last.bank} $. Хотите начать новую игру? (y/n)  "
    game_run if gets.chomp.downcase == 'y'
  end
  
  def inputs_name
    print 'Пожалуйста, введите свое имя ... ' # blink
    @name = gets.chomp # puts "Создан игрок - #{name}" 
    # validate name (w and d only; 1 - 20 letters)
  end

  def create_users(name)
    player = Player.new(name)
    diler = Player.new # можно сгенерировать имя... 
    players << diler << player
    players.each.with_index(1) { |player, i| puts "#{i}. #{player}" }
  end

  def login_user
    players.each do |player|
      2.times { player.get_card(deck.remove_card!) }
      # bank += player.give_money(10)
    end
     players.each.with_index(1) { |player, i| puts "#{i}. #{player}" }
  end

  def make_deck
    @deck = Deck.new
  end
end
