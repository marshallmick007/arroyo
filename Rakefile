require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :init do
  require_relative 'lib/arroyo'
end

task :test_exception => :init do
  #path = File.dirname(__FILE__)
  Arroyo::Backtrace.monkey_patch!
  Arroyo::Backtrace.show_only_app_exceptions!
  #Arroyo::Backtrace.show_only_app_exceptions!(File.dirname(__FILE__))
  1 / 0
end

task(:console => :init) do
  require 'irb'
  require 'irb/completion'

  ARGV.clear
  IRB.start
end
