# frozen_string_literal: true

class Card
  attr_reader :suit, :value

  SUITS = %w[♣ ♦ ♥ ♠].freeze
  RANKS = ['A', *(2..10), 'J', 'Q', 'K'].freeze

  def initialize(suit, value)
    raise "Invalid card value" unless RANKS.include? value

    @value = value
    raise "Invalid suit" unless SUITS.include? suit

    @suit = suit
  rescue StandardError => e
    puts "Возникла ошибка: #{e.message}"
  end

  def show
    [@suit, @value]
  end
end
