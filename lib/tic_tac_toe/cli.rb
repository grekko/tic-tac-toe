# frozen_string_literal: true

module TicTacToe
  # CLI for the TicTacToe Game
  class Cli
    attr_accessor :stdin, :stdout

    def initialize(stdin:, stdout:)
      @stdin  = stdin
      @stdout = stdout
    end

    def start_game
      writeln "Welcome!"
    end

    private

    def writeln(msg)
      $stdout.write "#{msg}\n"
    end
  end
end
