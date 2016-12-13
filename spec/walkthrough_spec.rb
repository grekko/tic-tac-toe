# frozen_string_literal: true

require "helper"

describe "Acceptance test for Human vs. Human play" do
  let(:path_to_cmd) { File.expand_path("../../bin/tictactoe", __FILE__) }
  let(:process)     { SpawnedProcess.new path_to_cmd }

  before do
    expect(process).to_not be_nil
  end

  after do
    puts "closing"
  end

  it "provides the proper UI feedback" do
    # Expect title
    expect(process.clean_output).to include "Unbeatable Tic Tac Toe"

    # Provide a false answer and expect failure message
    process.writeln "3"
    expect(process.clean_output).to include "Your answer isn't within the expected range"

    # Pick first Player being Human
    process.writeln "1"

    # Expect prompt for setting the second player
    expect(process.clean_output).to include(
      "Second Player 0:"
    )
    process.writeln "1"

    # Expect prompt for setting the starting player
    expect(process.clean_output).to include "Choose which player (1 or 2) should start:"
    process.writeln "1"

    # Expect
    output = process.clean_output
    puts output
  end
end
