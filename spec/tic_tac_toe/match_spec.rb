# frozen_string_literal: true

require "helper"

RSpec.describe TicTacToe::Match do
  subject { described_class.new players }
  let(:players) { [first, second] }
  let(:first)   { double("First Player") }
  let(:second)  { double("Second Player") }

  describe "#current_player" do
    it "returns the first player" do
      expect(subject.current_player).to eq(first)
    end
  end

  describe "#start_with" do
  end

  describe "#next_player" do
  end

  describe "#game_over?" do
  end
end
