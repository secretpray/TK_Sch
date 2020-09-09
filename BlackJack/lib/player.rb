# frozen_string_literal: true
class Player
  # include Validation #(проверка наличия имени, формата, проверка положительного баланса?)
  attr_reader :name, :bank

  def initialize(name = :diler)
    @name = name.to_sym
    @hand = Hand.new
    @bank = 100
  end

  def to_s
    "Name - #{name}, bank: #{bank} $"
  end
end
