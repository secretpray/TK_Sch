# frozen_string_literal: true

class Logic
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
    round.show_winner(player)
    player.take_money(20)
    @bank_game = 0
  end

  def standoff(players)
    players[0].take_money(10)
    players[1].take_money(10)
    @bank_game = 0
  end
end
