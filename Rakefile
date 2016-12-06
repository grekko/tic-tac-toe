require "rspec/core/rake_task"
require "rubocop/rake_task"

desc "Run all specs"
RSpec::Core::RakeTask.new :spec do |t|
  t.ruby_opts = %w(-w)
end

RuboCop::RakeTask.new

task default: %i(spec rubocop)
