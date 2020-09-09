# frozen_string_literal: true
require_relative 'interface'
require_relative 'player'
require_relative 'hand'
require_relative 'card'
require_relative 'deck'
require_relative 'validation'



class Round
  include Validation #(проверка 3 карты, перебор, очередность и правильность выбора)

  attr_reader :name, :deck

  attr_accessor :bank, :players


  def initialize
    @interface  = Interface.new
    @bank = 0
    @players = []
    prepare
  end

  def prepare
    inputs_name
    create_users(name)
    make_deck 
  end

  def start_round(name)
    # login_user
  end

  def inputs_name
    print 'Пожалуйста, введите свое имя ... ' # blink
    @name = gets.chomp
    # validate name (w and d only; 1 - 20 letters)
    puts "Создан игрок - #{name}" 
  end

  def create_users(name)
    player = Player.new(name)
    diler = Player.new # можно сгенерировать имя... 
    players << diler << player
    players.each.with_index(1) { |player, i| puts "#{i}. #{player}" }
  end

  def make_deck
    @deck = Deck.new
    info_deck(deck)
  end 

  def info_deck(info_deck)
    info_deck.cards.each.with_index(1) { |card, index| puts "#{index}. #{card.to_s} = (#{card.value})" } 
    puts "Карт в наличии: - #{info_deck.remaining}" # 52
  end
end
