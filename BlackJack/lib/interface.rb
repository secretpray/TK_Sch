# frozen_string_literal: true

class Interface
  attr_reader :round

  def initialize(round)
    @round = round
  end

  def play_menu
    puts "\n"
    puts '1 - Пропустить ход'.green
    puts '2 - Добавить карту'.green unless round.players_three_cards?
    puts '3 - Открыть карты'.green
    puts '-' * 17
    print 'Ваш ход   '.cyan.blink
    gets.chomp.to_i
  end

  def show_winner(player)
    system 'clear'
    if player.nil?
      puts 'Ничья'.bg_green
    else
      puts "Победил #{player.name.capitalize}!".bg_green
    end
    puts "\nСтатистика:"
  end

  def view(players, results = :close)
    round.show_bank
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
