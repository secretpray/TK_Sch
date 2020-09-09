# frozen_string_literal: true
class Player
  # include Validation #(проверка наличия имени, формата, проверка положительного баланса?)
  attr_reader :name, :bank, :hand

  def initialize(name = :diler)
    @name = name.to_sym
    @hand = Hand.new
    @bank = 100
  end

  def to_s
    "Name - #{name}, bank: #{bank} $"
  end
  
  def clear_hands
    @hand = Hand.new
  end

  def get_card(card)
    @hand << card
  end

  def give_money(value = 0)
    raise NoMoneyError unless value bank.negative?

    bank -= value
    value
  end

  def take_money(value = 0)
    @bank += value
  end

  def shadow_score
    @hand.score
  end

  def show_score(mode = :close)
    case mode
    when :close
      shadow_score
    when :open
      score
    end
  end

  def show_cards(mode = :close)
    case mode
    when :close
      shadow_cards
    when :open
      @hand.show
    end
  end
  
  def shadow_cards
    @hand.show
  end

  def cards_count
    @hand.cards.count
  end

  # private
  
  def score
    @hand.score
  end
end
