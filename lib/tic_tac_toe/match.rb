# frozen_string_literal: true

module TicTacToe
  # Handles players and the game board
  class Match
    attr_accessor :players

    def initialize(players)
      @players = players
    end

    def current_player
      @players.first
    end
  end
end
