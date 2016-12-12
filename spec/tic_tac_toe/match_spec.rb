# frozen_string_literal: true

require "helper"

RSpec.describe TicTacToe::Match do
  class FakePlayer
    attr_accessor :board
  end

  subject { described_class.new players }
  let(:players) { [first, second] }
  let(:first)   { FakePlayer.new }
  let(:second)  { FakePlayer.new }

  describe "#initialize" do
    let(:board) { subject.board }

    it "gives each player access to the game board" do
      expect(board).not_to be_nil
      expect(first.board).to eq(board)
      expect(second.board).to eq(board)
    end
  end

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

      it "is over" do
        expect(subject).to be_game_over
      end
    end

    context "with a not-yet solved board" do
      before do
        allow(subject.board).to receive(:solved?).and_return(false)
      end

      it "is not over" do
        expect(subject).to_not be_game_over
      end
    end
  end
end
