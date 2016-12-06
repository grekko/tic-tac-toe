require "rspec/core/rake_task"

desc "Run all specs"
RSpec::Core::RakeTask.new :spec do |t|
  t.ruby_opts = %w[-w]
end

task default: %i[spec]

