# frozen_string_literal: true

class Interface
  attr_reader :round

	def initialize(round)
    @round = round
  end
  
  def play_menu
    puts "\n"
    puts('1 - Пропустить ход')
    puts('2 - Добавить карту') unless round.three_cards?
    puts('3 - Открыть карты')
    puts '-' *17
    puts ('0 - Покинуть игру')
    print 'Ваш ход   '
    gets.chomp.to_i
  end

  def show_winner(player)
    if player.nil? 
      puts "\nНичья"
    else
      puts "\nПобедил #{player.name}!"
    end
    puts "\nСтатистика:"
  end

  def table_summary(players, results = :close)
    round.show_bank
    players.each { |player| results == :open ? summary(player, :open) : summary(player) }
  end

  def summary(player, mode = :close)
  	  puts("#{player_resume(player)} #{player_cards(player, mode)}")
  end

  def player_resume(player)
    "#{player.name.capitalize.to_s.ljust(10)} $#{player.bank.to_s.ljust(5)}"
  end

  def player_cards(player, mode = :close)
    "#{player.show_score(player, mode).to_s.rjust(2)} #{show_cards(player, mode)}"
  end

  # def resume(players)
  #   players.each { |player| puts("#{player.name.capitalize} $#{player.bank}") }
  # end
  
  def show_cards(player, mode)
    player.show_cards(player, mode).map { |card| "|#{card[0]} #{card[1]}|" }.join
  end
end
