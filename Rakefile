require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task(:init) do
  require_relative 'lib/arroyo'
end

task(:console => :init) do
  require 'irb'
  require 'irb/completion'

  ARGV.clear
  IRB.start
end
