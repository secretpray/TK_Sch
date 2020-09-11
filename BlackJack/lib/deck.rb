# frozen_string_literal: true

class Deck
  attr_accessor :decs

  def initialize
    @decs = set_generate.shuffle!
  end

  def shuffle!
    decs.shuffle!
  end

  def pop!
    @decs.pop
  end

  def remaining
    @cards.length
  end

  private

  def set_generate
    decs = []
    Card::SUITS.each do |suit|
      decs.concat(Card::RANKS.map { |value| Card.new(suit, value) })
    end
    decs
  end
end
