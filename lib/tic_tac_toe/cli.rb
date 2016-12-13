# frozen_string_literal: true

require "highline"

class TicTacToe
  # Encapsulates communication with commandline
  class Cli
    attr_reader :stdin, :stdout

    def initialize(stdin: $stdin, stdout: $stdout)
      @stdin  = stdin
      @stdout = stdout
      @stdout.sync = true # Enables immediate flushing
    end

    def ask(*args, &blok)
      highline.ask(*args, &blok)
    end

    def agree(msg)
      highline.agree msg
    end

    def say(msg)
      writeln msg
    end

    def print(msg)
      say msg
    end

    def clear
      reset_screen
    end

    private

    def highline
      @highline ||= HighLine.new(stdin, stdout)
    end

    def reset_screen
      wipe_screen
      writeln "Unbeatable Tic Tac Toe"
      writeln "======================"
      writeln ""
    end

    def wipe_screen
      clear_screen && cursor_topleft
    end

    def cursor_topleft
      write ANSI.cursor_topleft
    end

    def clear_screen
      write ANSI.clear_screen
    end

    def write(msg)
      stdout.write msg
    end

    def writeln(msg)
      write "#{msg}\n"
    end

    # ANSI Table
    # https://en.wikipedia.org/wiki/ANSI_escape_code
    class ANSI
      class << self
        ESC = 27.chr

        def escape(sequence)
          ESC + "[" + sequence
        end

        def clear_screen
          escape "2J"
        end

        def cursor_topleft
          escape "1;1H"
        end
      end
    end
  end
end
