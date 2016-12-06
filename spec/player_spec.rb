# frozen_string_literal: true

require "helper"
require "player"

RSpec.describe Player do
  describe "#init" do
    it "works" do
      expect(described_class.new).to_not be_nil
    end
  end
end
