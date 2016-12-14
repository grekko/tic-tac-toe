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
    context "with an empty board" do
      it "picks a random corner" do
        expect([1, 3, 7, 9]).to include(subject.pick_field)
      end
    end
  end

  describe "#to_s" do
    it "displays the Players name properly" do
      expect(subject.to_s).to eq("Player 2 (π, Computer)")
    end
  end
end
