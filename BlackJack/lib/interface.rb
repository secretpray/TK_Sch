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
    puts '-' *15
    puts ('0 - Покинуть игру')
    print 'Ваш ход   '
    gets.chomp.to_i
  end

  # def actions_list(player)
  #   puts('p - пропустить ход')
  #   puts('a - добавить карту') if player.cards_count < 3
  #   puts('o - открыть карты')
  # end

  def show_winner(player)
    puts('Ничья') if player.nil?
    puts("Победил #{player.name}")
  end

  def show_game_winner(player)
    puts('Ничья.') if player.nil?
    puts("Игра окончена. Победил #{player.name} $#{player.bank}")
  end

  def select_decision(player)
    if player.name != :diler
      play_menu # actions_list(player)
      decision = gets.chomp.to_i
    end
    decision
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
    "#{player.show_score(mode).to_s.rjust(2)} #{show_cards(player, mode)}"
  end

  def resume(players)
    round.show_bank
    players.each { |player| puts("#{player.name.capitalize} $#{player.bank}") }
  end
  
  def show_cards(player, mode)
    player.show_cards(mode).map { |card| "|#{card[0]} #{card[1]}|" }.join
  end
end
