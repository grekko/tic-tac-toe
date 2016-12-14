# frozen_string_literal: true

require "helper"

RSpec.describe TicTacToe::HumanPlayer do
  subject     { described_class.new number: 1, symbol: "X", cli: cli }
  let(:cli)   { instance_double("TicTacToe::Cli", clear: true, print: true) }
  let(:board) { instance_double("TicTacToe::Board", empty_fields: [], apply_move: true) }

  before do
    subject.board = board
  end

  describe "#make_move" do
    it "asks the human player via cli for the next move" do
      expect(cli).to receive(:ask).and_return("1")
      subject.make_move
    end

    it "applies the generated move to the board" do
      next_move = instance_double("Move")
      allow(subject).to receive(:next_move).and_return(next_move)
      expect(board).to receive(:apply_move).with(next_move)
      subject.make_move
    end
  end

  describe "#to_s" do
    it "displays the Players name properly" do
      expect(subject.to_s).to eq("Player 1 (X, Human)")
    end
  end
end
