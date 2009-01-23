require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'flexmock'
require 'flexmock/test_unit'

require 'lib/garmin'

def tcx_fixture_file
  File.join(File.dirname(__FILE__), 'fixtures', 'example.tcx')
end

def parsed_tcx
  Nokogiri.XML(open(tcx_fixture_file).read)
end
