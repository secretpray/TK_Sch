class Card
  attr_reader :face, :suit

  SUITS = %w[♣ ♦ ♥ ♠].freeze
  RANKS = ['A', *(2..10), 'J', 'Q', 'K'].freeze

	def initialize(face, suit)
    raise "Invalid card" unless (1..13).include? face

    @face = face
    raise "Invalid suit" unless ["spades", "hearts", "diamonds", "clubs"].include? suit

    @suit = suit
  rescue
    puts "Error!"
  end

  # def value
  #   if face == 1
  #     value = 11
  #   else
  #     (2..10).include?(face) ? value = face : value = 10
  #   end
  # end

  #  def to_s
  #    "#{["","Ace",*(2..10),"Jack","Queen","King"][face].to_s }\
  # #{{spades: "♠", hearts: "♥", diamonds: "♦", clubs: "♣"}[suit.to_sym]}"
  #  end

  def show_card
    [@face, @suit]
  end
  

end