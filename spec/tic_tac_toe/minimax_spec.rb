# frozen_string_literal: true

require "helper"

RSpec.describe TicTacToe::Minimax do
  subject { described_class.new(board) }
  let(:board) { instance_double("Board", fields: fields) }
end
