# frozen_string_literal: true

class TicTacToe
  # Represents game board
  class ComputerPlayer
    HORIZONTAL_WINNING_ROWS = [[1, 2, 3], [4, 5, 6], [7, 8, 9]].freeze
    VERTICAL_WINNING_ROWS   = [[1, 4, 7], [2, 5, 8], [3, 6, 9]].freeze
    DIAGONAL_WINNING_ROWS   = [[1, 5, 9], [3, 5, 7]].freeze
    WINNING_ROWS = HORIZONTAL_WINNING_ROWS +
                   VERTICAL_WINNING_ROWS +
                   DIAGONAL_WINNING_ROWS
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
      field = pick_field
      sleep 2
      board.update field: field, symbol: symbol
    end

    def pick_field
      case board.picked_fields.length
      when 0
        handle_empty_board
      when 1
        handle_second_move
      when 2
        handle_third_move
      else
        handle_fourth_move
      end
    end

    def to_s
      "Player #{number} (#{symbol}, Computer)"
    end

    private

    def handle_fourth_move
      [winning_pick, defending_pick, board.empty_fields.sample].compact.first
    end

    def winning_pick
      detect_winning_pick my_fields
    end

    def my_fields
      board.my_fields symbol: symbol
    end

    def opponent_fields
      board.picked_fields - my_fields
    end

    def detect_winning_pick(fields)
      board.empty_fields.detect do |field|
        possible_row = fields + [field]
        WINNING_ROWS.any? do |winning_row|
          (winning_row & possible_row).length == 3
        end
      end
    end

    def defending_pick
      detect_winning_pick opponent_fields
    end

    def handle_third_move
      if at_least_one_edge_picked?
        Board::CENTER_FIELD
      else
        any_free_corner_field
      end
    end

    def handle_empty_board
      Board::CORNER_FIELDS.sample
    end

    def handle_second_move
      if at_least_one_corner_picked?
        Board::CENTER_FIELD
      elsif center_picked?
        any_free_corner_field
      else
        corner_close_to_taken_edge
      end
    end

    def any_free_corner_field
      (Board::CORNER_FIELDS & board.empty_fields).sample
    end

    def corner_close_to_taken_edge
      [1, -1].sample + board.picked_fields.first
    end

    def center_picked?
      !board.empty_fields.include?(Board::CENTER_FIELD)
    end

    def at_least_one_edge_picked?
      (board.empty_fields & Board::EDGE_FIELDS).length < Board::EDGE_FIELDS.length
    end

    def at_least_one_corner_picked?
      (board.empty_fields & Board::CORNER_FIELDS).length < Board::CORNER_FIELDS.length
    end

    def turn_message
      "#{self}, its your turn.\n\nThe board:\n===========\n#{board}"
    end
  end
end
