# frozen_string_literal: true

class TicTacToe
  # Represents game board
  class Board
    def initialize
      @fields = [
        nil, nil, nil,
        nil, nil, nil,
        nil, nil, nil,
      ]
    end

    def solved?
      symbols.any? do |symbol|
        [
          [1, 2, 3],
          [1, 4, 7],
          [1, 5, 9],
          [2, 5, 8],
          [4, 5, 6],
          [9, 6, 3],
          [9, 8, 7],
        ].any? do |field_ids|
          field_ids.all? { |id| @fields[id-1] == symbol }
        end
      end
    end

    def update(field:, symbol:)
      @fields[field-1] = symbol
    end

    def empty_fields
      @fields.each_with_index.map { |f, i| [f.nil?, i+1] }.select { |b, i| b }.map(&:last)
    end

    def to_s
      " #{field(0)} | #{field(1)} | #{field(2)} \n" +
      "---+---+---\n" +
      " #{field(3)} | #{field(4)} | #{field(5)} \n" +
      "---+---+---\n" +
      " #{field(6)} | #{field(7)} | #{field(8)} \n"
    end

    private

    def symbols
      @fields.uniq.compact
    end

    def field(id)
      @fields[id] || id+1
    end
  end
end
