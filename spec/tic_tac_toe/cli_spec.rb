# frozen_string_literal: true

require "helper"

RSpec.describe TicTacToe::Cli do
  subject { described_class.new(stdin: stdin, stdout: stdout) }
  let(:stdin)    { StringIO.new }
  let(:stdout)   { StringIO.new }
  let(:highline) { instance_double("Highline") }

  describe "#initialize" do
    it "sets sync to true the provided stdout to disable output buffering" do
      expect(stdout).to receive(:sync=).with(true)
      described_class.new(stdout: stdout)
    end
  end

  describe "#ask" do
    it "delegates #ask to the highline instance" do
      expect(subject.highline).to receive(:ask).with(:any_arg)
      subject.ask(:any_arg)
    end
  end

  describe "#agree" do
    it "delegates #agree to the highline instance" do
      expect(subject.highline).to receive(:agree).with(:any_arg)
      subject.agree(:any_arg)
    end
  end

  describe "#say" do
    it "writes to stdout and appends a newline" do
      subject.say "T.V. EYE?"
      expect(stdout.string).to eq "T.V. EYE?\n"
    end
  end

  describe "#clear" do
    it "writes the proper ANSI code to stdout for clearing the TTY and resetting the cursor" do
      subject.clear
      expect(stdout.string.start_with?("\e[2J\e[1;1")).to eq true
    end
  end
end
