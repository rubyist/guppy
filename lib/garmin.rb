require File.join(File.dirname(__FILE__), 'garmin', 'activity')
require File.join(File.dirname(__FILE__), 'garmin', 'track_point')
require File.join(File.dirname(__FILE__), 'garmin', 'tcx_parser')
require File.join(File.dirname(__FILE__), 'garmin', 'gpx_parser')
require File.join(File.dirname(__FILE__), 'garmin', 'db')

module Garmin
  TCX = 'tcx'
  GPX = 'gpx'
  
  def self.version
    "1.0"
  end
end
