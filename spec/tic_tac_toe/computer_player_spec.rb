# frozen_string_literal: true

require "helper"

RSpec.describe TicTacToe::ComputerPlayer do
  subject     { described_class.new number: 2, symbol: "X", cli: cli }
  let(:cli)   { instance_double("TicTacToe::Cli", clear: true, print: true) }
  let(:board) { instance_double("TicTacToe::Board", empty_fields: %w(2 3 4)) }

  before do
    subject.board = board
  end

  describe "#make_move" do
    it "always takes the lowest available empty field" do
      expect(board).to receive(:update).with(field: "2", symbol: subject.symbol)
      subject.make_move
    end
  end

  describe "#to_s" do
    it "displays the Players name properly" do
      expect(subject.to_s).to eq("Player 2 (Computer)")
    end
  end
end
