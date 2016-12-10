# frozen_string_literal: true

module TicTacToe
  # CLI for the TicTacToe Game
  class Cli
    def start_game
      reset
      write "Hi, whats your name?: "
      name = gets.chomp
      reset
      writeln "Hi #{name}!"
      write "Like to play tic tac toe? Y/N: "
    end

    private

    def reset
      clear_screen && cursor_topleft
    end

    def cursor_topleft
      write ANSI.cursor_topleft
    end

    def clear_screen
      write ANSI.clear_screen
    end

    def write(msg)
      $stdout.write msg
    end

    def writeln(msg)
      write "#{msg}\n"
    end
  end

  # ANSI Table
  # https://en.wikipedia.org/wiki/ANSI_escape_code
  class ANSI
    class << self
      ESC = 27.chr

      def escape(sequence)
        ESC + "[" + sequence
      end

      def clear_line
        escape "2K"
      end

      def clear_screen
        escape "2J"
      end

      def cursor_topleft
        escape "1;1H"
      end

      def cursor_up
        escape "1A"
      end
    end
  end
end
