# frozen_string_literal: true

class Deck
  attr_accessor :decs

  def initialize
    @decs = build_deck.shuffle!
  end

  def deal(num = 1)
    num == 1 ? decs.pop : decs.pop(num)
  end

  private

  def build_deck
    Card::SUITS.each_with_object([]) do |suit, array|
      Card::RANKS.each do |rank|
        array << Card.new(suit, rank)
      end
    end
  end
end
