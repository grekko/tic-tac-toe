# frozen_string_literal: true

class TicTacToe
  # Represents game board
  class Board
    attr_reader :fields

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
      @fields = {
        1 => nil, 2 => nil, 3 => nil,
        4 => nil, 5 => nil, 6 => nil,
        7 => nil, 8 => nil, 9 => nil
      }
    end

    def fields=(symbols)
      symbols.each_with_index do |symbol, position|
        fields[position + 1] = symbol
      end
    end

    def solved_for_symbol?(symbol)
      WINNING_SETS.any? do |field_ids|
        field_ids.all? { |id| fields[id] == symbol }
      end
    end

    def solved?
      symbols.any? { |symbol| solved_for_symbol?(symbol) }
    end

    def picked_fields
      fields.select { |_, symbol| !symbol.nil? }.keys
    end

    def full?
      picked_fields.size == fields.size
    end

    def with_move(field:, symbol:)
      self.class.new.tap do |board|
        board.fields = fields.values
        board.update field: field, symbol: symbol
      end
    end

    def update(field:, symbol:)
      fields[field] = symbol
    end

    def empty_fields
      fields.select { |_, symbol| symbol.nil? }.keys
    end

    def to_s
      " #{field(1)} | #{field(2)} | #{field(3)} \n" \
        "---+---+---\n" \
        " #{field(4)} | #{field(5)} | #{field(6)} \n" \
        "---+---+---\n" \
        " #{field(7)} | #{field(8)} | #{field(9)} \n"
    end

    def symbols
      fields.values.uniq.compact
    end

    private

    def field(id)
      fields[id] || id
    end
  end
end
