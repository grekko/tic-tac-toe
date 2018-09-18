# frozen_string_literal: true

require "helper"

RSpec.describe TicTacToe::Board do
  subject { described_class.new }

  describe "#solved_for_symbol?" do
    context "for a board with a winning X line" do
      before do
        subject.fields = [
          "X", "X", "X",
          nil, nil, nil,
          nil, nil, nil,
        ]
      end

      it "returns true for X" do
        expect(subject.solved_for_symbol?("X")).to eq true
      end

      it "returns false for 0" do
        expect(subject.solved_for_symbol?("0")).to eq false
      end
    end
  end

  describe "#solved?" do
    context "for a board with a winning line" do
      before do
        subject.fields = [
          "X", "X", "X",
          nil, nil, nil,
          nil, nil, nil,
        ]
      end

      it "returns true" do
        expect(subject).to be_solved
      end
    end

    context "for a board with another winning line" do
      before do
        subject.fields = [
          "0", nil, "X",
          nil, "0", nil,
          "X", "X", "0",
        ]
      end

      it "returns true" do
        expect(subject).to be_solved
      end
    end

    context "for a new board" do
      it "returns false" do
        expect(subject).to_not be_solved
      end
    end
  end

  describe "full?" do
    context "for an empty board" do
      it "returns false" do
        expect(subject).to_not be_full
      end
    end

    context "for a partial filled board" do
      before do
        subject.fields = [
          "X", nil, nil,
          "0", nil, "X",
          nil, "X", "0"
        ]
      end

      it "returns false" do
        expect(subject).to_not be_full
      end
    end

    context "for a full board" do
      before do
        subject.fields = %w[
          X 0 X
          0 0 X
          X X 0
        ]
      end

      it "returns true" do
        expect(subject).to be_full
      end
    end
  end

  describe "#picked_fields" do
    context "for a new board" do
      it "returns no fields" do
        expect(subject.picked_fields).to eq([])
      end
    end

    context "for a partially filled board" do
      before do
        subject.fields = [
          "X", nil, nil,
          "0", nil, "X",
          nil, "X", "0"
        ]
      end

      it "returns the picked fields" do
        expect(subject.picked_fields).to eq [1, 4, 6, 8, 9]
      end
    end
  end

  describe "#empty_fields" do
    context "for a new board" do
      it "returns all fields" do
        expect(subject.empty_fields).to eq((1..9).to_a)
      end
    end

    context "for a partially filled board" do
      before do
        subject.fields = [
          "X", nil, nil,
          "0", nil, "X",
          nil, "X", "0"
        ]
      end

      it "returns just the available fields" do
        expect(subject.empty_fields).to eq [2, 3, 5, 7]
      end
    end
  end

  describe "#with_move" do
    context "for a partially filled board" do
      before do
        subject.fields = [
          nil, nil, nil,
          "0", nil, "X",
          nil, "X", "0"
        ]
      end

      it "returns a copy of the board" do
        new_board = subject.with_move(field: 1, symbol: "ANY")
        expect(new_board.object_id).to_not eq(subject.object_id)
      end

      it "sets applies the provided symbol to the given field" do
        expect(subject.fields[1]).to be_nil
        new_board = subject.with_move(field: 1, symbol: "🍺")
        expect(new_board.fields[1]).to eq("🍺")
      end

      it "keeps all pre-existing fields" do
        new_board = subject.with_move(field: 1, symbol: "🍺")

        (2..9).each do |position|
          expect(new_board.fields[position]).to eq subject.fields[position]
        end
      end
    end
  end

  describe "#update" do
    it "updates fields with the given symbol" do
      expect(subject.fields[1]).to be_nil
      subject.update field: 1, symbol: "π"
      expect(subject.fields[1]).to eq("π")
    end
  end

  describe "#to_s" do
    context "for a new board" do
      it "renders correctly" do
        expect(subject.to_s).to eq(
          " 1 | 2 | 3 \n" \
          "---+---+---\n" \
          " 4 | 5 | 6 \n" \
          "---+---+---\n" \
          " 7 | 8 | 9 \n"
        )
      end
    end

    context "for a partially filled board" do
      before do
        subject.fields = [
          "X", nil, nil,
          "0", nil, "X",
          nil, "X", "0"
        ]
      end

      it "renders correctly" do
        expect(subject.to_s).to eq(
          " X | 2 | 3 \n" \
          "---+---+---\n" \
          " 0 | 5 | X \n" \
          "---+---+---\n" \
          " 7 | X | 0 \n"
        )
      end
    end
  end
end
