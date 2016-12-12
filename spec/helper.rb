# frozen_string_literal: true

require "simplecov"
SimpleCov.start

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.allow_message_expectations_on_nil = false
  end
end

Dir[__dir__ + "/../lib/**/*.rb"].each { |f| require f }
