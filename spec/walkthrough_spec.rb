# frozen_string_literal: true

require "helper"

describe "Acceptance test for Human vs. Human play" do
  let(:path_to_cmd) { File.expand_path("../../bin/tictactoe", __FILE__) }
  let(:process)     { SpawnedProcess.new path_to_cmd }

  before do
    expect(process).to_not be_nil
  end

  after do
    process.close
  end

  it "provides the proper UI feedback" do
    # Expect title and setup message
    output = process.clean_output
    expect(output).to include "Unbeatable Tic Tac Toe"
    expect(output).to include "Pick either a Human (1) or Computer (2) player"

    # Provide a false answer and expect failure message
    process.writeln "3"
    expect(process.clean_output).to include "Your answer isn't within the expected range"

    # Pick first Player being X, Human
    process.writeln "1"

    # Expect prompt for setting the second player
    expect(process.clean_output).to include(
      "Second Player 0:"
    )
    process.writeln "1"

    # Expect prompt for setting the starting player
    expect(process.clean_output).to include "Choose which player (1 or 2) should start:"
    process.writeln "1"

    # Expect board to be rendered
    output = process.clean_output
    board = CliParsedBoard.new(output)
    expect(output).to include "Player 1 (X, Human), its your turn."
    expect(board.to_a).to eq %w(
      1 2 3
      4 5 6
      7 8 9
    )
    expect(output).to include "Pick an empty field (1, 2, 3, 4, 5, 6, 7, 8, 9):"
    process.writeln "5"

    # Expect board to be updated
    output = process.clean_output
    board = CliParsedBoard.new(output)
    expect(output).to include "Player 2 (0, Human), its your turn."
    expect(board.to_a).to eq %w(
      1 2 3
      4 X 6
      7 8 9
    )
    expect(output).to include "Pick an empty field (1, 2, 3, 4, 6, 7, 8, 9):"
    process.writeln "1"

    # Expect board to be updated
    output = process.clean_output
    board = CliParsedBoard.new(output)
    expect(output).to include "Player 1 (X, Human), its your turn."
    expect(board.to_a).to eq %w(
      0 2 3
      4 X 6
      7 8 9
    )
    expect(output).to include "Pick an empty field (2, 3, 4, 6, 7, 8, 9):"
    process.writeln "8"

    # Expect board to be updated
    output = process.clean_output
    board = CliParsedBoard.new(output)
    expect(output).to include "Player 2 (0, Human), its your turn."
    expect(board.to_a).to eq %w(
      0 2 3
      4 X 6
      7 X 9
    )
    expect(output).to include "Pick an empty field (2, 3, 4, 6, 7, 9):"
    process.writeln "4"

    # Expect board to be updated
    output = process.clean_output
    board = CliParsedBoard.new(output)
    expect(output).to include "Player 1 (X, Human), its your turn."
    expect(board.to_a).to eq %w(
      0 2 3
      0 X 6
      7 X 9
    )
    expect(output).to include "Pick an empty field (2, 3, 6, 7, 9):"
    process.writeln "2"

    # Expect game to be over
    output = process.clean_output
    expect(output).to include "Congrats! Player 1 (X, Human) won!"
    expect(output).to include "Want to play another round? (Y/N)"

    # Choose Yes
    process.writeln "Y"
    output = process.clean_output
    expect(output).to include "Pick either a Human (1) or Computer (2) player"
  end
end
