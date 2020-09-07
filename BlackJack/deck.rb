require_relative 'card'

class Deck
  attr_accessor :cards, :cards_played
  
  def initialize
    @cards = (1..13).to_a.product(["spades", "hearts", "diamonds", "clubs"]).collect{ |f,s| Card.new(f,s) }
    @cards_played = []
    # shuffle!
  end

  def draw(n=1)
    draw = @cards.sample(n).each do |card|
      @cards_played.push @cards.delete(card)
    end
  end

  def shuffle!
    @cards.shuffle!
  end

  def draw
    @cards.pop
  end

  def remaining
    @cards.length
  end
end

deck_one = Deck.new
deck_one.cards.each.with_index(1) { |card, index| puts "#{index} - #{card.to_s} (#{card.value})" } 
puts "cards remaining (@cards.length) - #{deck_one.remaining}" # 52