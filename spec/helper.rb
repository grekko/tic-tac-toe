# frozen_string_literal: true

require "simplecov"
SimpleCov.start

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.allow_message_expectations_on_nil = false
  end
end

require "pty"
require "timeout"
class SpawnedProcess
  ANSI_REGEXP = /\e\[\d+/
  ProcessMaybeGoneError = Class.new(StandardError)

  attr_accessor :stdout, :stdin, :pid

  def initialize(command)
    @stdout, @stdin, @pid = PTY.spawn command
    @stdout.sync = true
    @stdin.sync  = true
  end

  def puts(string)
    writeln string
    clean_stdout
  end

  def clean_stdout
    output_without_ansi_codes
  end

  def close
    [stdout, stdin].each(&:close)
    Process.kill "TERM", pid
  end

  private

  def output
    Timeout.timeout(0.5) do
      stdout.gets.tap do |string_or_nil|
        raise ProcessMaybeGoneError if string_or_nil.nil?
      end
    end + output
  rescue Timeout::Error, ProcessMaybeGoneError
    ""
  end

  def output_without_ansi_codes
    output.gsub ANSI_REGEXP, ""
  end

  def writeln(string)
    stdin.write "#{string}\n"
  end
end

class CliParsedBoard
  BOARD_REGEXP = /(.+)\s---\+---\+---\n(.+)\s---\+---\+---\s(.+)/

  def initialize(string)
    @string = string.delete("\r")
  end

  def to_a
    return unless match

    match.captures.map { |line| line.split("|").map(&:strip) }.flatten
  end

  def match
    @match ||= @string.match(BOARD_REGEXP)
  end
end

Dir[__dir__ + "/../lib/**/*.rb"].each { |f| require f }
