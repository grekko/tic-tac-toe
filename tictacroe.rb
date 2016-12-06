# frozen_string_literal: true

require_relative "lib/tic_tac_toe/cli"

TicTacToe::Cli.new(stdin: $stdin, stdout: $stdout)
