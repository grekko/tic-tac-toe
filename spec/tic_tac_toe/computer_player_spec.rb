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
    let(:corner_fields) { TicTacToe::Board::CORNER_FIELDS }
    let(:edge_fields)   { TicTacToe::Board::EDGE_FIELDS }

    context "with an empty board" do
      it "picks a random corner" do
        expect(corner_fields).to include(subject.pick_field)
      end
    end

    context "with the opponent starting" do
      context "in a corner" do
        before { board.fields[corner_fields.sample - 1] = "X" }

        it "picks the center" do
          expect(subject.pick_field).to eq(TicTacToe::Board::CENTER_FIELD)
        end
      end

      context "in the center" do
        before { board.fields[TicTacToe::Board::CENTER_FIELD - 1] = "X" }

        it "picks any corner" do
          expect(TicTacToe::Board::CORNER_FIELDS).to include(subject.pick_field)
        end
      end

      context "on an edge" do
        let(:any_edge_field) { edge_fields.sample }
        before { board.fields[any_edge_field - 1] = "X" }

        it "picks a corner next to the taken edge" do
          expect([any_edge_field + 1, any_edge_field - 1]).to include(subject.pick_field)
        end
      end
    end
  end

  describe "#to_s" do
    it "displays the Players name properly" do
      expect(subject.to_s).to eq("Player 2 (π, Computer)")
    end
  end
end
