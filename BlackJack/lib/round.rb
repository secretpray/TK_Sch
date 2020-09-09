# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'
require_relative 'interface'
require_relative 'validation'



class Round
  include Validation #(проверка 3 карты, перебор, очередность и правильность выбора)

  attr_reader :name

  attr_accessor :bank


  def initialize
    @interface  = Interface.new
    @bank = 0
    @players = []
    prepare
  end

  def prepare
    inputs_name
    # create_users
    # make/shuffle deck 
  end

  def start_round(name)
    # login_user
  end

  def inputs_name
    print 'Пожалуйста, введите свое имя ... ' # blink
    @name = gets.chomp
    # validate name (w and d only; 1 - 20 letters)
    puts "Создан игрок - #{@name} (#{name})" 
  end

  def create_users(name)
  end
end
