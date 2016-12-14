# frozen_string_literal: true

require "helper"

RSpec.describe TicTacToe::ComputerPlayer do
  subject     { described_class.new number: 2, symbol: "π", cli: cli }
  let(:cli)   { instance_double("TicTacToe::Cli", clear: true, print: true) }
  let(:board) { TicTacToe::Board.new }

  before do
    subject.board = board
  end

  describe "#pick_field" do
    let(:minimax) { instance_double("Minimax", pick_field_with_highest_score: 1) }

    it "delegates the pick to Minimax" do
      expect(Minimax).to receive(:new).with(board: board).and_return(minimax)
      expect(subject.pick_field).to eq(minimax.pick_field_with_highest_score)
    end
  end

  describe "#to_s" do
    it "displays the Players name properly" do
      expect(subject.to_s).to eq("Player 2 (π, Computer)")
    end
  end
end
