# Rakefile for garmin -*- ruby -*-
begin
  require "rubygems"
  require "rake/gempackagetask"
  require "rake/testtask"
  require "rake/rdoctask"
rescue Exception
  nil
end

if `ruby -Ilib -rgarmin -e "print Garmin.version"` =~ /([0-9.]+)$/
  CURRENT_VERSION = $1
else
  CURRENT_VERSION = '0.0.0'
end

desc "Run all tests"
task :default => [:test]

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/test*.rb']
  t.warning = true
  t.verbose = false
end
