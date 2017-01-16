# frozen_string_literal: true

class TicTacToe
  # My naive first attempt to implement an unbeatable computer player.
  # Partially based on: https://www.quora.com/Is-there-a-way-to-never-lose-at-Tic-Tac-Toe
  #
  # I discovered a more robust and deterministic approach using the Minimax-Algorithm
  # which is described here: http://neverstopbuilding.com/minimax although I
  # decided to stick w/ my more "creative" solution.
  class ComputerPlayer
    attr_accessor :board
    attr_reader :number, :symbol, :cli

    def initialize(number:, symbol:, cli:)
      @number = number
      @symbol = symbol
      @cli    = cli
    end

    def next_move
      take_some_time_to_think_about_the_next_move
      pick_field
    end

    def pick_field
      [defending_pick, early_picks, winning_pick, any_pick].compact.first
    end

    def to_s
      "Player #{number} (#{symbol}, Computer)"
    end

    private

    def take_some_time_to_think_about_the_next_move
      Kernel.sleep 2
    end

    def defending_pick
      detect_winning_pick symbol: opponent_symbol
    end

    def opponent_symbol
      (board.symbols - [symbol]).first
    end

    def winning_pick
      detect_winning_pick symbol: symbol
    end

    def any_pick
      board.empty_fields.sample
    end

    def detect_winning_pick(symbol:)
      board.empty_fields.detect do |field|
        board.with_move(field: field, symbol: symbol).solved?
      end
    end

    def early_picks
      case board.picked_fields.length
      when 0
        handle_empty_board
      when 1
        handle_second_move
      when 2
        handle_third_move
      end
    end

    def handle_empty_board
      any_free_corner_field
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

    def handle_third_move
      if at_least_one_edge_picked?
        Board::CENTER_FIELD
      else
        any_free_corner_field
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
  end
end
