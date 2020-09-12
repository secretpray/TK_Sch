# frozen_string_literal: true

class Logic
  STOP_DEALER_SCORE = 17

  attr_reader :round

  def initialize(round)
    @round = round
  end

  def choose_winner(players)
    if (players[0].score > 21 && players[1].score > 21) || players[0].score == players[1].score
      standoff(players)
    elsif players[1].score > 21
      winner(players[0])
    elsif players[0].score > 21 || players[1].score > players[0].score
      winner(players[1])
    else
      winner(players[0])
    end
  end

  def winner(player)
    player.take_money(20)
    view_result(player)
  end

  def standoff(players)
    players[0].take_money(10)
    players[1].take_money(10)
    view_result(player = nil)
  end

  def view_result(player)
    @bank_game = 0
    round.show_winner(player)
  end

  def diler_step(players)
    if players.first.score < STOP_DEALER_SCORE && players.first.hand.cards.size < Round::MAX_CARDS
      rand(0..51).odd? ? round.add_card(:diler) : round.play_game # пусть подумает))
    else
      round.play_game
    end
  end
end
