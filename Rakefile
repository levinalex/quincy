$LOAD_PATH.unshift './lib'

require 'bundler'
Bundler::GemHelper.install_tasks


require 'quincy'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

task :default => :spec

