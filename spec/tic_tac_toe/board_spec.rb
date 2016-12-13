# frozen_string_literal: true

require "helper"

RSpec.describe TicTacToe::Board do
  subject { described_class.new }

  describe "#solved?" do
    context "for a board with a winning line" do
      before do
        subject.fields = %w(
          X X X
          4 5 0
          0 8 0
        )
      end

      it "returns true" do
        expect(subject).to be_solved
      end
    end

    context "for a board with another winning line" do
      before do
        subject.fields = %w(
          0 2 X
          4 0 6
          X X 0
        )
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
        subject.fields = [
          "X", "0", "X",
          "0", "0", "X",
          "X", "X", "0"
        ]
      end

      it "returns true" do
        expect(subject).to be_full
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

  describe "#update" do
    it "updates fields with the given symbol" do
      expect(subject.fields[0]).to be_nil
      subject.update field: 1, symbol: "π"
      expect(subject.fields[0]).to eq("π")
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
