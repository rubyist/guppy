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

desc 'Generate documentation for garmin'
rd = Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'html'
  rdoc.template = 'doc/jamis.rb'
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = 'garmin'
  rdoc.options << '--line-numbers' << '--inline-source' << '--main' << 'README.rdoc' << '--title' << 'Magic Bus'
  rdoc.rdoc_files.include('README.rdoc', 'lib/**/*.rb', 'doc/**/*.rdoc')
end


desc "Run all tests"
task :default => [:test]

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/test*.rb']
  t.warning = true
  t.verbose = false
end

desc "Verify gemspec for github"
task :verify_gemspec do
  data = File.read('garmin.gemspec')
  spec = nil
  if data !~ %r{!ruby/object:Gem::Specification}
    Thread.new { spec = eval("$SAFE = 3\n#{data}") }.join
  else
    spec = YAML.load(data)
  end

  spec.validate
  puts spec
  puts "OK"
end
