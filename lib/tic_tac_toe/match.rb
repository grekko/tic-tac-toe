# frozen_string_literal: true

class TicTacToe
  # Handles players and the game board
  class Match
    attr_accessor :players

    def initialize(players)
      @players = players
    end

    def next_player
      players.rotate!.last
    end
end
