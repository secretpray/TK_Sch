# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'
require_relative 'interface'
require_relative 'validation'



class Round
  include Validation #(проверка 3 карты, перебор, очередность и правильность выбора)

  attr_accessor :bank


  def initialize
    @interface  = Interface.new
    @bank = 0
    @players = []
    prepare
  end

  def prepare
    # inputs name
    # make/shuffle deck 
  end

  def start_round(name)
    
  end

