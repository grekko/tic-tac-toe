# frozen_string_literal: true

class TicTacToe
  # Represents game board
  class ComputerPlayer
    attr_accessor :board
    attr_reader :number, :symbol, :cli

    def initialize(number:, symbol:, cli:)
      @number = number
      @symbol = symbol
      @cli    = cli
    end

    def make_move
      board.update field: board.empty_fields.first, symbol: symbol
    end

    def to_s
      "Player #{number} (Computer)"
    end
  end
end
