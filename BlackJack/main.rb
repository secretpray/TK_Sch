# frozen_string_literal: true

require_relative 'lib/round'
require_relative 'lib/interface'
require_relative 'lib/player'
require_relative 'lib/hand'
require_relative 'lib/card'
require_relative 'lib/deck'
require_relative 'lib/logic'
require_relative 'lib/validation'
require_relative 'lib/string'
require 'io/console'

class Main
  # include Validation #(проверка 3 карты, перебор, очередность и правильность выбора) 
  
  round = Round.new
  round.start_round
  system 'clear'
end
