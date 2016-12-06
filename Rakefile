# frozen_string_literal: true

require "rspec/core/rake_task"
require "rubocop/rake_task"

desc "Run all specs"
RSpec::Core::RakeTask.new :spec do |t|
  t.ruby_opts = %w(-w)
end

require "cucumber/rake/task"
Cucumber::Rake::Task.new(:cucumber)

RuboCop::RakeTask.new

task default: %i(cucumber spec rubocop)
