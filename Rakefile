# Rakefile for garmin -*- ruby -*-
require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = 'garmin'
    gemspec.summary = 'Ruby library for parsing tcx and gpx files'
    gemspec.description = 'foo'
    gemspec.email = 'scott@elitists.net'
    gemspec.homepage = 'http://github.com/rubyist/garmin'
    gemspec.authors = ['Scott Barron']
    gemspec.add_development_dependency "thoughtbot-shoulda", ">= 0"
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available."
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available."
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "garmin #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
