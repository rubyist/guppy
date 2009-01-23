require File.join(File.dirname(__FILE__), 'activity')
require File.join(File.dirname(__FILE__), 'track_point')
require File.join(File.dirname(__FILE__), 'tcx_parser')
require File.join(File.dirname(__FILE__), 'gpx_parser')
require File.join(File.dirname(__FILE__), 'db')

module Garmin
  TCX = 'tcx'
  GPX = 'gpx'
  
  def self.version
    "1.0"
  end
end
