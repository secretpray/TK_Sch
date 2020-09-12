# frozen_string_literal: true

class Card
  attr_reader :suit, :value
  SUITS = %w[♦️ ♣️ ♠️ ♥️].freeze
  # SUITS = %w[♣ ♦ ♥ ♠].freeze
  RANKS = ['A', *(2..10), 'J', 'Q', 'K'].freeze

  def initialize(suit, value)
    @value = value
    @suit = suit
  end

  def show
    [@suit, @value]
  end
end
