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
      cli.clear
      cli.print turn_message
      sleep 2
      board.update field: pick_field, symbol: symbol
    end

    def pick_field
      if board.empty?
        [1, 3, 7, 9].sample
      end
    end

    def to_s
      "Player #{number} (#{symbol}, Computer)"
    end

    private

    def turn_message
      "#{self}, its your turn.\n\nThe board:\n===========\n#{board}"
    end
  end
end
