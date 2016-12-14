# frozen_string_literal: true

class TicTacToe
  # Represents game board
  class Board
    attr_accessor :fields

    CORNER_FIELDS = [1, 3, 7, 9].freeze
    CENTER_FIELD  = 5
    EDGE_FIELDS   = [2, 4, 6, 8].freeze

    def initialize
      @fields = Array.new(9) { nil }
    end

    def solved?
      symbols.any? do |symbol|
        winning_lines.any? do |field_ids|
          field_ids.all? { |id| @fields[id - 1] == symbol }
        end
      end
    end

    def my_fields(symbol:)
      fields.each_with_index.map { |f, i| [f, i + 1] }.select { |f, _| f == symbol }.map(&:last)
    end

    def empty?
      empty_fields.length == fields.length
    end

    def picked_fields
      (1..9).to_a - empty_fields
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
        [4, 5, 6],
        [7, 8, 9],
        [1, 4, 7],
        [2, 5, 8],
        [3, 6, 9],
        [1, 5, 9],
        [3, 5, 7],
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
