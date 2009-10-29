require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'flexmock'
require 'flexmock/test_unit'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'guppy'

def tcx_fixture_file
  File.join(File.dirname(__FILE__), 'fixtures', 'example.tcx')
end

def parsed_tcx
  Nokogiri.XML(open(tcx_fixture_file).read)
end
