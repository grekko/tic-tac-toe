# frozen_string_literal: true

require "helper"

RSpec.describe TicTacToe::Match do
  subject { described_class.new players }
  let(:players) { [first, second] }
  let(:first)   { double("First Player") }
  let(:second)  { double("Second Player") }

  describe "#next_player" do
    it "returns the first player" do
      expect(subject.next_player).to eq(first)
    end

    it "returns the second player when being called twice" do
      subject.next_player
      expect(subject.next_player).to eq(second)
    end

    it "returns the first player again, when being called three times" do
      subject.next_player
      subject.next_player
      expect(subject.next_player).to eq(first)
    end
  end

  describe "#game_over?" do
    context "with a solved board" do
      before do
        allow(subject.board).to receive(:solved?).and_return(true)
      end

      it "returns true" do
        expect(subject).to be_game_over
      end
    end
  end
end
