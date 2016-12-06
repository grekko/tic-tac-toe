# frozen_string_literal: true

require "simplecov"
SimpleCov.command_name ARGV.join(" ")
SimpleCov.start do
  add_filter "/features/"
end
