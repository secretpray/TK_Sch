# frozen_string_literal: true

class Round
  BETS = 10

  attr_reader :name, :deck, :open, :interface, :logic, :skip_player
  attr_accessor :bank_game, :players

  def initialize
    @logic = Logic.new(self)
    @interface = Interface.new(self)
    @bank = 0 # @bank -> user
    @bank_game = 0
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
  end

  def play_game
    loop do
      break if three_cards?

      interface.view(players, :close)
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
        puts Interface::UNKNOWN_COMMAND.red
        press_key
      end
    end
    end_round
  end

  def skip_step
    raise Interface::ONE_SKIP unless skip_player.zero?

    @skip_player += 1
    clear
    puts Interface::NEXT_STEP
    logic.diler_step(players)
  rescue StandardError => e
    puts Interface::HAVE_ERRORS.gray + e.message.to_s.red
    press_key
  end

  def add_card(player)
    raise Interface::HAVE_THREE_CARDS if players_three_cards?

    player == :diler ? players[0].get_card(@deck.deal) : players[1].get_card(@deck.deal)
    clear
  rescue StandardError => e
    puts Interface::HAVE_ERRORS.gray + e.message.to_s.red
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
    puts Interface::BET_GAME + "$#{@bank_game}".green.bold
    puts Interface::LINE * 17
    puts
  end

  def end_round
    @bank_game = 0
    @skip_player = 0
    logic.choose_winner(players)
    interface.view(players, :open)
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

  def press_key
    printf Interface::PRESS_KEY_BLINK
    loop do
      break if [' ', "\r"].include?(STDIN.getch)
    end
    clear
  end

  def clear
    system 'clear'
  end
end
