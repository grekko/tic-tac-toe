# frozen_string_literal: true

require_relative "move"

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
      cli.print turn_message
      board.apply_move next_move
    end

    def to_s
      "Player #{number} (#{symbol}, Human)"
    end

    private

    def next_move
      field = cli.ask(pick_message, Integer) { |q| q.in = board.empty_fields }
      Move.new(index: field.to_i - 1, symbol: symbol)
    end

    def turn_message
      "#{self}, its your turn.\n\nThe board:\n===========\n#{board}"
    end

    def pick_message
      "Pick an empty field (#{board.empty_fields.join(', ')}):\n"
    end
  end
end
