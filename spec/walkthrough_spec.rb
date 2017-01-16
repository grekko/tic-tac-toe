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

  it "allows a successful walkthrough of the game (Human vs. Human)" do
    # Expect title and setup message
    stdout = process.clean_stdout
    expect(stdout).to include "Unbeatable Tic Tac Toe"
    expect(stdout).to include "Pick either a Human (1) or Computer (2) player"
    expect(stdout).to include "First Player X:"

    # Provide a false answer and expect failure message
    stdout = process.puts "3"
    expect(stdout).to include "Your answer isn't within the expected range"

    # Pick a human first player (playing with symbol X)
    stdout = process.puts "1"
    # Expect prompt for setting the second player
    expect(stdout).to include "Second Player 0:"

    stdout = process.puts "1"

    # Expect prompt for setting the starting player
    expect(stdout).to include "Choose which player (1 or 2) should start:"
    stdout = process.puts "1"

    # Expect board to be rendered
    board = CliParsedBoard.new(stdout)
    expect(stdout).to include "Player 1 (X, Human), its your turn."
    expect(board.to_a).to eq %w(
      1 2 3
      4 5 6
      7 8 9
    )
    expect(stdout).to include "Pick an empty field (1, 2, 3, 4, 5, 6, 7, 8, 9):"

    # Expect board to be updated
    stdout = process.puts "5"
    board = CliParsedBoard.new(stdout)
    expect(stdout).to include "Player 2 (0, Human), its your turn."
    expect(board.to_a).to eq %w(
      1 2 3
      4 X 6
      7 8 9
    )
    expect(stdout).to include "Pick an empty field (1, 2, 3, 4, 6, 7, 8, 9):"
    stdout = process.puts "1"

    # Expect board to be updated
    board = CliParsedBoard.new(stdout)
    expect(stdout).to include "Player 1 (X, Human), its your turn."
    expect(board.to_a).to eq %w(
      0 2 3
      4 X 6
      7 8 9
    )
    expect(stdout).to include "Pick an empty field (2, 3, 4, 6, 7, 8, 9):"
    stdout = process.puts "8"

    # Expect board to be updated
    board = CliParsedBoard.new(stdout)
    expect(stdout).to include "Player 2 (0, Human), its your turn."
    expect(board.to_a).to eq %w(
      0 2 3
      4 X 6
      7 X 9
    )
    expect(stdout).to include "Pick an empty field (2, 3, 4, 6, 7, 9):"
    stdout = process.puts "4"

    # Expect board to be updated
    board = CliParsedBoard.new(stdout)
    expect(stdout).to include "Player 1 (X, Human), its your turn."
    expect(board.to_a).to eq %w(
      0 2 3
      0 X 6
      7 X 9
    )
    expect(stdout).to include "Pick an empty field (2, 3, 6, 7, 9):"
    stdout = process.puts "2"

    # Expect game to be over and final board being displayed
    board = CliParsedBoard.new(stdout)
    expect(board.to_a).to eq %w(
      0 X 3
      0 X 6
      7 X 9
    )
    expect(stdout).to include "Congrats! Player 1 (X, Human) won!"
    expect(stdout).to include "Want to play another round? (Y/N)"

    # Choose Yes
    stdout = process.puts "Y"
    expect(stdout).to include "Pick either a Human (1) or Computer (2) player"
  end

  it "offers to start a new match if nobody wins" do
    # Pick first Player Human (X)
    process.puts "1"

    # Pick second Player Human (0)
    process.puts "1"

    # First player starts
    process.puts "1"

    # From here on, generate the following final board to provoke a draw:
    # X O O
    # O X X
    # X X O

    # First player (X):
    process.puts "1"
    # Second player (0):
    process.puts "2"
    # First player (X):
    process.puts "5"
    # Second player (0):
    process.puts "3"
    # First player (X):
    process.puts "6"
    # Second player (0):
    process.puts "4"
    # First player (X):
    process.puts "7"
    # Second player (0):
    process.puts "9"
    # First player (X):
    stdout = process.puts "8"

    expect(stdout).to include "Nobody wins!"
    expect(stdout).to include "Want to play another round? (Y/N)"

    stdout = process.puts "Y"
    # Now we start all over again :)
    expect(stdout).to include "Pick either a Human (1) or Computer (2) player"
    expect(stdout).to include "First Player X:"
  end
end
