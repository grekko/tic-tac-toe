# frozen_string_literal: true

# Based on the work of http://neverstopbuilding.com/minimax
class Minimax
  attr_accessor :board, :opponents_turn

  def initialize(board:, opponents_turn: false)
    @board = board
    @opponents_turn = opponents_turn
  end

  def pick_field_with_highest_score
    return opponents_move ? -1 : 1 if board.solved?
    return 0 if board.full?
    board.empty_fields.map do |available_fields|
      available_move =
      next_board = board.after_move(available_move)
      [
        available_move,
        new(board: next_board, opponents_turn: !opponents_turn)
      ]
    end.tap do |scores|
    end
  end
end
