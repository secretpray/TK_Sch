# frozen_string_literal: true
class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end
  
  def <<(card)
    if card.face == 'A'
      @cards << card
    else
      @cards.unshift(card)
    end
      @cards
  end

  def show
    @cards.map(&:show_card)
  end
  
  def score
    @hands.inject(0) do |sum, card|
      t = if %w[J Q K].include?(card.face)
            10
          elsif card.face == 'A'
            sum + 11 >= 21 ? 1 : 11
          else
            card.face
          end
      sum + t
    end
  end
end
