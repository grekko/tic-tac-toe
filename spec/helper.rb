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

  def clean_output
    output_without_ansi_codes
  end

  def writeln(msg)
    stdin.write "#{msg}\n"
  end

  def close
    [stdout, stdin].each(&:close)
    Process.kill "TERM", pid
  end
end

Dir[__dir__ + "/../lib/**/*.rb"].each { |f| require f }
