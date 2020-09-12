# frozen_string_literal: true

class Player
  # include Validation #(проверка наличия имени, формата, проверка положительного баланса?)
  attr_accessor :name, :bank, :hand

  def initialize(name = :diler)
    @name = name.to_sym
    @hand = Hand.new
    @bank = 100
  end

  def clear_hands
    @hand = Hand.new
  end

  def get_card(card)
    @hand << card
  end

  def give_money(value = 0)
    raise "недостаточно денег! Ставка #{value}$ (остаток #{bank}$)" if (bank - value).negative?

    @bank -= value
  rescue StandardError => e
    puts "Возникла ошибка: #{e.message}"
  end

  def take_money(value = 0)
    @bank += value
  end

  def shadow_score
    @hand.score
  end

  def show_score(player, mode = :close)
    case mode
    when :close
      player.name == :diler ? shadow_score : score
    when :open
      score
    end
  end

  def show_cards(player, mode = :close)
    case mode
    when :close
      player.name == :diler ? shadow_cards : @hand.show
    when :open
      @hand.show
    end
  end

  def shadow_score
    'xx'
  end

  def shadow_cards
    cards = []
    @hand.cards.size.times { cards << ['*', '*'] }
    cards
  end

  def score
    @hand.score
  end
end
