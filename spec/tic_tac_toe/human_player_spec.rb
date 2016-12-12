# frozen_string_literal: true

require "helper"
require "stringio"

RSpec.describe TicTacToe::HumanPlayer do
  subject { described_class.new symbol: "X", stdin: stdin, stdout: stdout }
  let(:stdin)  { StringIO.new }
  let(:stdout) { StringIO.new }
end
