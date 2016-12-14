# frozen_string_literal: true

class TicTacToe
  # Represents a single move
  class Move
    attr_accessor :index, :symbol
    def initialize(index:, symbol:)
      @index  = index
      @symbol = symbol
    end
  end
end
