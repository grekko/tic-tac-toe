# frozen_string_literal: true

require_relative "board"

class TicTacToe
  # Handles players and the game board
  class Match
    attr_accessor :players, :board

    def initialize(players)
      @players = players
      @board = Board.new
      @players.each { |player| player.board = @board }
    end

    def ask_player_for_move_and_apply(player)
      board.update field: player.next_move, symbol: player.symbol
    end

    def next_player
      players.rotate!.last
    end

    def game_won?
      board.solved?
    end

    def board_full?
      board.full?
    end
  end
end
