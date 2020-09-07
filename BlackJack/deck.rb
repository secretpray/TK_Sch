require_relative 'card'

class Deck
  # SUITS = ["Clubs","Hearts","Spades","Diamonds"].freeze
  # SUITS = %i(♣ ♠ ♥ ♦).freeze
  # FACES = [*(2..10), 'Jack', 'Queen', 'King', 'Ace'].freeze # *() - «splat» разложение диапазона на отдельные элементы

  attr_accessor :cards, :cards_played
  
  def initialize
    @cards = (1..13).to_a.product(["spades", "hearts", "diamonds", "clubs"]).collect{|n,s| Card.new(n,s)}
    @cards_played = []
  # @cards ||= []
  # SUITS.each do |suit|
  #   FACES.each do |value| 
  #     @cards << Card.new(suit, value)
  #     end
  #   end
  shuffle!
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
deck_one.cards.each.with_index(1) { |card, index| puts "#{index} - #{card.to_s}" } 
puts "cards remaining (@cards.length) - #{deck_one.remaining}" # 52
