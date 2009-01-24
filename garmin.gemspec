spec = Gem::Specification.new do |s|
  s.name = 'garmin'
  s.version = '0.1'
  s.summary = 'Ruby library for parsing Garming tcx files'
  s.files = ["MIT-LICENSE", "Rakefile", "README.rdoc", "README.rdoc", "lib/activity.rb", "lib/db.rb", "lib/garmin.rb", "lib/gpx_parser.rb", "lib/lap.rb", "lib/tcx_parser.rb", "lib/track_point.rb"]
  s.require_path = 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc']
  s.rdoc_options = ['--line-numbers', '--inline-source', '--main', 'README.rdoc', '--title', 'garmin']
  s.author = "Scott Barron"
  s.email = "scott@elitists.net"
  s.homepage = "https://github.com/rubyist/garmin/tree"
end
