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
      case board.picked_fields.length
      when 0
        handle_empty_board
      when 1
        handle_second_move
      end
    end

    def to_s
      "Player #{number} (#{symbol}, Computer)"
    end

    private

    def handle_empty_board
      Board::CORNER_FIELDS.sample
    end

    def handle_second_move
      if at_least_one_corner_picked?
        Board::CENTER_FIELD
      elsif center_picked?
        Board::CORNER_FIELDS.sample
      else
        corner_close_to_taken_edge
      end
    end

    def corner_close_to_taken_edge
      [1, -1].sample + board.picked_fields.first
    end

    def center_picked?
      !board.empty_fields.include?(Board::CENTER_FIELD)
    end

    def at_least_one_corner_picked?
      (board.empty_fields & Board::CORNER_FIELDS).length < Board::CORNER_FIELDS.length
    end

    def turn_message
      "#{self}, its your turn.\n\nThe board:\n===========\n#{board}"
    end
  end
end
