require_relative 'card'

class Deck
  attr_accessor :cards, :cards_played
  
  def initialize
    @cards = generate_cards.shuffle!
    @cards_played = []
  end

  def remove_card!
    cards.pop
  end

  def remaining
    @cards.length
  end

  private

  def generate_cards
    (1..13).to_a.product(["spades", "hearts", "diamonds", "clubs"]).collect{ |f,s| Card.new(f,s) }
  end
end
