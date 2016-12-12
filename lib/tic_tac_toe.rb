# frozen_string_literal: true

require "highline"
require_relative "tic_tac_toe/match"

# TODO
class TicTacToe
  attr_accessor :stdin, :stdout

  def initialize(stdin: $stdin, stdout: $stdout)
    @stdin  = stdin
    @stdout = stdout
  end

  def start
    display "Welcome to Tic Tac Toe"
    start_game_loop
  end

  def start_game_loop
    loop do
      match = Match.new picked_players_in_starting_order
      loop do
        player = match.next_player
        player.make_move
        break if match.game_over?
      end
      writeln "Congrats! #{player} won!"
      continue_with_next_match_or_exit
    end
  end

  def picked_players_in_starting_order
    pick_players.reverse.rotate starting_player
  end

  def starting_player
    display "Choose which player (1 or 2) should start."
    highline.ask("Choose: ", Integer) { |q| q.in = 1..2 }
  end

  def pick_players
    display "Pick either a Human (1) or Computer (2) player."
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

  def player_type(number:, symbol:)
    {
      0 => HumanPlayer,
      1 => ComputerPlayer,
    }[number].new symbol: symbol, stdin: stdin, stdout: stdout
  end

  private

  def pick_player_number(question)
    highline.ask("#{question}: ", Integer) { |q| q.in = 1..2 }
  end

  def continue_with_next_match_or_exit
    exit unless highline.agree("Want to play another round?")
  end

  def highline
    @highline ||= HighLine.new(stdin, stdout)
  end

  def display(msg)
    reset_screen
    writeln msg
  end

  def reset_screen
    wipe_screen
    writeln "Unbeatable Tic Tac Toe"
    writeln "======================"
    writeln ""
  end

  def wipe_screen
    clear_screen && cursor_topleft
  end

  def cursor_topleft
    write ANSI.cursor_topleft
  end

  def clear_screen
    write ANSI.clear_screen
  end

  def write(msg)
    stdout.write msg
  end

  def writeln(msg)
    write "#{msg}\n"
  end

  # ANSI Table
  # https://en.wikipedia.org/wiki/ANSI_escape_code
  class ANSI
    class << self
      ESC = 27.chr

      def escape(sequence)
        ESC + "[" + sequence
      end

      def clear_screen
        escape "2J"
      end

      def cursor_topleft
        escape "1;1H"
      end
    end
  end
end
