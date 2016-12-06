# frozen_string_literal: true
require "helper"

RSpec.describe TicTacToe::Cli do
  describe "#initialize" do
    it "takes stdin and stdout as arguments" do
      described_class.new(stdin: Object.new, stdout: Object.new)
    end
  end
end
