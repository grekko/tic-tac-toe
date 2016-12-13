# frozen_string_literal: true

class TicTacToe
  # Represents game board
  class HumanPlayer
    attr_accessor :board
    attr_reader :number, :symbol, :cli

    def initialize(number:, symbol:, cli:)
      @number = number
      @symbol = symbol
      @cli    = cli
    end

    def make_move
      cli.clear
      cli.print "#{to_s}, its your turn.\n\nThe board:\n===========\n#{board}"
      field = cli.ask("Pick an empty field (#{board.empty_fields.join(", ")}):\n", Integer) { |q| q.in = board.empty_fields }
      board.update field: field, symbol: symbol
    end

    def to_s
      "Player #{number} (Human)"
    end
  end
end
