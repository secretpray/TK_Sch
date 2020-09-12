# frozen_string_literal: true

class Round
  include View

  BETS      = 10
  MAX_CARDS = 3

  attr_reader :name, :deck, :open, :interface, :logic, :skip_player
  attr_accessor :bank_game, :players

  def initialize
    @logic = Logic.new(self)
    @interface = Interface.new(self)
    @bank = 0 # bank User
    @bank_game = 0 # bank Bets
    @skip_player = 0
    @players = []
    @open = false
    prepare_round
  end

  def prepare_round
    inputs_name
    create_users(name)
  end

  def inputs_name
    clear
    @name = interface.getiing_name
    clear
  end

  def create_users(name)
    player = Player.new(name)
    diler = Player.new
    players << diler << player
  end

  def start_round
    players.each(&:clear_hands)
    @deck = Deck.new
    login_user
    play_game
  end

  def login_user
    @open = false
    players.each do |player|
      2.times { player.get_card(@deck.deal) }
      @bank += player.give_money(BETS)
      @bank_game += BETS
    end
  rescue StandardError => e
    Interface.show_error_message(e)
    press_key
  end

  def play_game
    loop do
      break if three_cards?

      view(players, :close)
      input = interface.play_menu
      case input
      when 1
        skip_step
      when 2
        add_card(:player)
      when 3
        @open = true
        break
      else
        interface.show_error_command
        press_key
      end
    end
    end_round
  end

  def skip_step
    raise Interface::ONE_SKIP unless skip_player.zero?

    @skip_player += 1
    clear
    interface.next_step
    logic.diler_step(players)
  rescue StandardError => e
    Interface.show_error_message(e)
    press_key
  end

  def add_card(player)
    raise Interface::HAVE_THREE_CARDS if players_three_cards?

    player == :diler ? players[0].get_card(@deck.deal) : players[1].get_card(@deck.deal)
    clear
  rescue StandardError => e
    Interface.show_error_message(e)
    press_key
    clear
  end

  def players_three_cards?
    players[1].hand.cards.size >= 3
  end

  def three_cards?
    players[0].hand.cards.size >= 3 && players[1].hand.cards.size >= 3
  end

  def show_bank
    interface.show_game_bank(@bank_game)
  end

  def end_round
    @bank_game = 0
    @skip_player = 0
    logic.choose_winner(players)
    view(players, :open)
    interface.game_result(players)
    if interface.new_game?
      clear
      start_round
    else
      clear
      exit
    end
  end

  def show_winner(player)
    interface.game_over
    if player.nil?
      interface.show_draw
    else
      interface.show_player_winner(player)
    end
  end

  def skip_player_zero?
    skip_player.nonzero?
  end

  def press_key
    interface.pres_key_blink
    loop do
      break if [' ', "\r"].include?(STDIN.getch)
    end
    clear
  end

  def clear
    interface.clear_console
  end
end
