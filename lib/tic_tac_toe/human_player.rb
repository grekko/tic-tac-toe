# frozen_string_literal: true

class TicTacToe
  # Represents game board
  class HumanPlayer
    attr_accessor :board

    def initialize(symbol:, cli:)
      @symbol = symbol
      @cli    = cli
    end

    def make_move
      # NOOP
    end

    def to_s
      "Human"
    end
  end
end
