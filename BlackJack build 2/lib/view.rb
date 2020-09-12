# frozen_string_literal: true

module View
  def view(players, results = :close)
    show_bank
    players.each { |player| results == :open ? summary(player, :open) : summary(player) }
  end

  def summary(player, mode = :close)
    puts("#{player_data(player)} #{player_cards(player, mode)}")
  end

  def player_data(player)
    "#{player.name.capitalize.to_s.ljust(10)} $#{player.bank.to_s.ljust(5)}"
  end

  def player_cards(player, mode = :close)
    "#{player.show_score(player, mode).to_s.rjust(2)} #{show_cards(player, mode)}"
  end

  def show_cards(player, mode)
    player.show_cards(player, mode).map { |card| "|#{card[0]} #{card[1]}|" }.join
  end
end
