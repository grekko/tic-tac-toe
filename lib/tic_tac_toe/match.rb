# frozen_string_literal: true

class TicTacToe
  # Handles players and the game board
  class Match
    attr_accessor :players, :board

    def initialize(players)
      @players = players
      @board = Board.new
      @players.each { |player| player.board = @board }
    end

    def next_player
      players.rotate!.last
    end

    def game_over?
      board.solved?
    end
  end
end
