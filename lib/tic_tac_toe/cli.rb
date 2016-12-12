require "highline"

module TicTacToe
  class Cli
    attr_accessor :stdin, :stdout

    def initialize(stdin: $stdin, stdout: $stdout)
      @stdin, @stdout = stdin, stdout
    end

    def run
      display Game.welcome_message

      loop do
        match = Game::Match.new pick_players
        match.start_with pick_starting_player
        while match.active? do
          match.next_player.make_move
          if match.game_over?
            writeln "Congrats! #{match.current_player} won!"
          end
        end
      end
    end

    def pick_starting_player
      display "Choose which player (1 or 2) should start."
      highline.ask("Choose: ", Integer) { |q| q.in = 1..2 }
    end

    def pick_players
      display "Pick either a Human (1) or Computer (2) player."
      {
        "First Player"  => "X",
        "Second Player" => "0",
      }.map do |(player, symbol)|
        player_type number: highline.ask("#{player}: ", Integer) { |q| q.in = 1..2 }, symbol: symbol
      end
    end

    def player_type(number:, symbol:)
      {
        0 => Game::Player::Human,
        1 => Game::Player::Computer,
      }[number].new symbol: symbol, stdin: stdin, stdout: stdout
    end

    private

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
end
