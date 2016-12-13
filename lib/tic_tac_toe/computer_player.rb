# frozen_string_literal: true

class TicTacToe
  # Represents game board
  class ComputerPlayer
    def initialize(symbol:, stdin:, stdout:)
      @symbol = symbol
      @stdin  = stdin
      @stdout = stdout
    end
  end
end
