# frozen_string_literal: true

require_relative "lib/tic_tac_toe/cli"

cli = TicTacToe::Cli.new(stdin: $stdin, stdout: $stdout)
cli.start_game
