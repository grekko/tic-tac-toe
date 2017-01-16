# frozen_string_literal: true

class TicTacToe
  # Handles interaction w/ human player via CLI
  class HumanPlayer
    attr_accessor :board
    attr_reader :number, :symbol, :cli

    def initialize(number:, symbol:, cli:)
      @number = number
      @symbol = symbol
      @cli    = cli
    end

    def next_move
      cli.ask(pick_message, Integer) { |q| q.in = board.empty_fields }.to_i
    end

    def to_s
      "Player #{number} (#{symbol}, Human)"
    end

    private

    def pick_message
      "Pick an empty field (#{board.empty_fields.join(', ')}):\n"
    end
  end
end
