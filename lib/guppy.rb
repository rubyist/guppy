require 'nokogiri'
require 'time'

require File.join(File.dirname(__FILE__), 'guppy', 'activity')
require File.join(File.dirname(__FILE__), 'guppy', 'track_point')
require File.join(File.dirname(__FILE__), 'guppy', 'tcx_parser')
require File.join(File.dirname(__FILE__), 'guppy', 'gpx_parser')
require File.join(File.dirname(__FILE__), 'guppy', 'db')
require File.join(File.dirname(__FILE__), 'guppy', 'lap')

module Guppy
  TCX = 'tcx'
  GPX = 'gpx'
  
  def self.version
    "0.0.1"
  end
end
