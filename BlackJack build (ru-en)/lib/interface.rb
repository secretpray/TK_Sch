# frozen_string_literal: true

class Interface

  SELECT_LANG = '1 - русский язык, other enter - english language (default)'

  attr_reader :round

  def initialize(round)
    @round = round
  end

  def play_menu
    puts "\n"
    puts Localization.translate(:one_menu).green unless round.skip_player.nonzero?
    puts Localization.translate(:two_menu).green unless round.players_three_cards?
    puts Localization.translate(:three_menu).green
    puts '-'.green * 17
    print Localization.translate(:next_step).cyan.blink
    gets.chomp.to_i
  end

  def setting_language 
    puts SELECT_LANG
    gets.chomp.to_i == 1 ? 'ru'.to_sym : 'en'.to_sym 
  end

  def getiing_name
    print Localization.translate(:input_name).cyan
    gets.chomp
  end

  def game_over
    system 'clear'
    puts Localization.translate(:gave_over).gray.italic
  end

  def show_draw
    puts Localization.translate(:draw).bg_green
  end

  def new_game?
    print Localization.translate(:new_games).blink
    gets.chomp.strip.downcase == 'y'
  end

  def show_player_winner(player)
    puts Localization.translate(:win) + "#{player.name.capitalize}!".bg_green
  end

  def game_result(players)
    puts
    puts Localization.translate(:on_account) + "#{players.last.name}: $#{players.last.bank}\n".green.bold
  end

  def show_game_bank(bank_game)
    puts Localization.translate(:bet_games) + "$#{bank_game}".green.bold
    puts '-' * 17
    puts
  end

  def next_step
    puts Localization.translate(:next_step_diler)
  end

  def show_error_command
    puts Localization.translate(:unknown_command).red
  end

  def self.show_error_message(error)
    puts Localization.translate(:have_errors).gray + error.message.to_s.red
  end

  def pres_key_blink
    printf Localization.translate(:press_any_blink).blink
  end

  def clear_console
    system 'clear'
  end
end
