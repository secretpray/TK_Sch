class Card
  attr_reader :face, :suit

	def initialize(face, suit)
    raise "Invalid card" unless (1..13).include? face

    @face = face
    raise "Invalid suit" unless ["spades", "hearts", "diamonds", "clubs"].include? suit

    @suit = suit
  end

  def to_s
    # ["","A",2,3,4,5,6,7,8,9,10,"J","Q","K"][face].to_s + 
    ["","A",*(2..10),"J","Q","K"][face].to_s + 
    {spades: "♠", hearts: "♥", diamonds: "♦", clubs: "♣"}[suit.to_sym]
  end
end