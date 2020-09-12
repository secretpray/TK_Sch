# frozen_string_literal: true

class Interface
  PRESS_KEY_BLINK   = "\nДля продолжения нажмите пробел или Enter.. \033[1;5m_\033[0;25m\n"
  WIN               = 'Победил '
  DRAW              = 'Ничья'
  GAME_OVER         = "Игра окончена...\n"
  UNKNOWN_COMMAND   = 'Неизвестная команда!'
  NEXT_STEP         = 'Противник принял решение! Ход за Вами...'
  ONE_SKIP          = 'пропуск хода возможен только один раз!'
  HAVE_THREE_CARDS  = 'на руках уже 3 карты!'
  ONE_MENU          = '1 - Пропустить ход'
  TWO_MENU          = '2 - Добавить карту'
  THREE_MENU        = '3 - Открыть карты'
  LINE              = '-'
  NEXT_STEP         = 'Ваш ход   '
  INPUT_NAME        = 'Пожалуйста, введите свое имя ... '
  NEW_GAMES         = 'Хотите начать новую игру? (y/*)  '
  BET_GAME          = 'Ставки игры: '
  HAVE_ERRORS       = 'Возникла ошибка: '
  NO_MONEY          = 'недостаточно денег!'

  attr_reader :round

  def initialize(round)
    @round = round
  end

  def play_menu
    puts "\n"
    puts ONE_MENU.green
    puts TWO_MENU.green unless round.players_three_cards?
    puts THREE_MENU.green
    puts LINE * 17
    print NEXT_STEP.cyan.blink
    gets.chomp.to_i
  end

  def getiing_name
    print INPUT_NAME.cyan
    gets.chomp
  end

  def game_over
    system 'clear'
    puts GAME_OVER.gray.italic
  end

  def show_draw
    puts DRAW.bg_green
  end

  def new_game?
    print NEW_GAMES.blink
    gets.chomp.strip.downcase == 'y'
  end

  def show_player_winner(player)
    puts WIN + "#{player.name.capitalize}!".bg_green
  end

  def game_result(players)
    puts "\nУ #{players.last.name} на счету:" + " $#{players.last.bank}\n".green.bold
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
