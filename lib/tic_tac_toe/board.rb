# frozen_string_literal: true

class TicTacToe
  # Represents game board
  class Board
    attr_accessor :fields

    CORNER_FIELDS = [1, 3, 7, 9].freeze
    CENTER_FIELD  = 5
    EDGE_FIELDS   = [2, 4, 6, 8].freeze

    HORIZONTAL_WINNING_SETS = [[1, 2, 3], [4, 5, 6], [7, 8, 9]].freeze
    VERTICAL_WINNING_SETS   = [[1, 4, 7], [2, 5, 8], [3, 6, 9]].freeze
    DIAGONAL_WINNING_SETS   = [[1, 5, 9], [3, 5, 7]].freeze
    WINNING_SETS = HORIZONTAL_WINNING_SETS +
                   VERTICAL_WINNING_SETS +
                   DIAGONAL_WINNING_SETS

    def initialize
      @fields = Array.new(9) { nil }
    end

    def solved_for_symbol?(symbol)
      WINNING_SETS.any? do |field_ids|
        field_ids.all? { |id| @fields[id - 1] == symbol }
      end
    end

    def solved?
      symbols.any? { |symbol| solved_for_symbol?(symbol) }
    end

    def picked_fields
      (1..9).to_a - empty_fields
    end

    def full?
      !empty_fields.any?
    end

    def with_move(field:, symbol:)
      self.class.new.tap do |board|
        board.fields = fields.dup
        board.update field: field, symbol: symbol
      end
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

    def symbols
      fields.uniq.compact
    end

    private

    def field(id)
      fields[id] || id + 1
    end
  end
end
