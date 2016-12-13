# frozen_string_literal: true

class TicTacToe
  # Represents game board
  class Board
    attr_accessor :fields

    def initialize
      @fields = 9.times.map { nil }
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

    def update(field:, symbol:)
      fields[field - 1] = symbol
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
      fields.uniq.compact
    end

    def field(id)
      fields[id] || id + 1
    end
  end
end
