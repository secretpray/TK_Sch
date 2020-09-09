# frozen_string_literal: true
require_relative 'interface'
require_relative 'player'
require_relative 'hand'
require_relative 'card'
require_relative 'deck'
require_relative 'validation'



class Round
  include Validation #(проверка 3 карты, перебор, очередность и правильность выбора)

  attr_reader :name

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
    # make/shuffle deck 
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
    diler = Player.new # можно сгенерировать имя... чтобы не был просто diler
    players << diler 
    players << player
    # players.each.with_index(1) { |p, i| puts "#{i}. Name - #{p.name}, bank: #{p.bank} $" }
    players.each.with_index(1) { |player, i| puts "#{i}. #{player}" }
  end
end
