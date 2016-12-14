# frozen_string_literal: true

class TicTacToe
  # Represents game board
  class Board
    attr_accessor :fields, :players

    def initialize(players: [])
      @players = players.each do |player|
        player.board = self
      end
      @fields = Array.new(9) { nil }
    end

    def empty?
      empty_fields.length == fields.length
    end

    # TODO: Instead take the field and create a move based on the `current_player`?
    def after_move(move)
      self.class.new(players: players).tap do |board|
        board.fields = fields
        board.apply_move move
      end
    end

    def solved?
      symbols.any? do |symbol|
        winning_lines.any? do |field_ids|
          field_ids.all? { |id| @fields[id - 1] == symbol }
        end
      end
    end

    def full?
      !empty_fields.any?
    end

    def apply_move(move)
      fields[move.index] = move.symbol
    end

    def empty_fields
      fields.each_with_index.map { |f, i| [f.nil?, i + 1] }.select { |b, _| b }.map(&:last)
    end

    def to_s
      " #{field(0)} | #{field(1)} | #{field(2)} \n" \
        "---+---+---\n" \
        " #{field(3)} | #{field(4)} | #{field(5)} \n" \
        "---+---+---\n" \
        " #{field(6)} | #{field(7)} | #{field(8)} \n"
    end

    private

    def winning_lines
      [
        [1, 2, 3],
        [1, 4, 7],
        [1, 5, 9],
        [2, 5, 8],
        [4, 5, 6],
        [9, 6, 3],
        [9, 8, 7],
      ]
    end

    def symbols
      players.map(&:symbol)
    end

    def field(id)
      fields[id] || id + 1
    end
  end
end
