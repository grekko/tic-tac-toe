# frozen_string_literal: true

require "simplecov"
SimpleCov.start

Dir[__dir__ + "/../lib/**/*.rb"].each { |f| require f }
