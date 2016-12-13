# frozen_string_literal: true

require_relative "tic_tac_toe/cli"
require_relative "tic_tac_toe/match"
require_relative "tic_tac_toe/human_player"
require_relative "tic_tac_toe/computer_player"

# TODO
class TicTacToe
  attr_reader :cli

  def initialize(stdin: $stdin, stdout: $stdout)
    @cli = Cli.new(stdin: stdin, stdout: stdout)
  end

  def start
    loop do
      match = Match.new picked_players_in_starting_order
      loop do
        player = match.next_player
        player.make_move
        break if match.game_over?
      end
      cli.say "Congrats! #{player} won!"
      continue_with_next_match_or_exit
    end
  end

  def picked_players_in_starting_order
    pick_players.reverse.rotate(starting_player).tap do |players|
      cli.say "You choose #{players[0]} vs #{players[1]}"
    end
  end

  def starting_player
    cli.clear
    cli.ask("Choose which player (1 or 2) should start:\n", Integer) { |q| q.in = 1..2 }
  end

  def pick_players
    print_pick_players_message
    {
      "First Player"  => "X",
      "Second Player" => "0",
    }.map do |(player, symbol)|
      player_type(
        number: pick_player_number("#{player} #{symbol}"),
        symbol: symbol,
      )
    end
  end

  def print_pick_players_message
    cli.clear
    cli.say "Pick either a Human (1) or Computer (2) player."
  end

  def player_type(number:, symbol:)
    {
      1 => HumanPlayer,
      2 => ComputerPlayer,
    }[number].new symbol: symbol, cli: cli
  end

  private

  def pick_player_number(question)
    cli.ask("#{question}:\n", Integer) { |q| q.in = 1..2 }
  end

  def continue_with_next_match_or_exit
    exit unless cli.agree("Want to play another round?\n")
  end
end
