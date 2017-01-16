# frozen_string_literal: true

require_relative "tic_tac_toe/cli"
require_relative "tic_tac_toe/match"
require_relative "tic_tac_toe/human_player"
require_relative "tic_tac_toe/computer_player"

# TODO
class TicTacToe
  PLAYERS = {
    "First Player"  => "X",
    "Second Player" => "0",
  }.freeze

  attr_reader :cli

  def initialize(stdin: $stdin, stdout: $stdout)
    @cli = Cli.new(stdin: stdin, stdout: stdout)
  end

  def start
    loop do
      match_loop new_match
      exit_unless_user_wants_to_continue
    end
  end

  def new_match
    Match.new picked_players_in_starting_order
  end

  def match_loop(match)
    loop do
      player = match.next_player
      display "#{player}, its your turn.\n\nThe board:\n===========\n#{match.board}"
      match.ask_player_for_move_and_apply player
      display("Congrats! #{player} won!\n\n#{match.board}") && break if match.game_won?
      display("Nobody wins!") && break if match.board_full?
    end
  end

  def picked_players_in_starting_order
    pick_players.reverse.rotate(starting_player).tap { cli.clear }
  end

  def starting_player
    cli.clear
    cli.ask("Choose which player (1 or 2) should start:\n", Integer) { |q| q.in = 1..2 }
  end

  def pick_players
    display "Pick either a Human (1) or Computer (2) player."
    PLAYERS.each_with_index.map do |(player, symbol), index|
      player_type(
        type: pick_player_type("#{player} #{symbol}"),
        number: index + 1,
        symbol: symbol,
      )
    end
  end

  def display(msg)
    cli.clear && cli.say(msg)
  end

  def player_type(type:, number:, symbol:)
    {
      human: HumanPlayer,
      computer: ComputerPlayer,
    }[type].new number: number, symbol: symbol, cli: cli
  end

  private

  def pick_player_type(question)
    {
      1 => :human,
      2 => :computer,
    }[cli.ask("#{question}:\n", Integer) { |q| q.in = 1..2 }]
  end

  def exit_unless_user_wants_to_continue
    exit unless cli.agree("Want to play another round? (Y/N)\n")
  end
end
