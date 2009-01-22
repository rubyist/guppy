require File.join(File.dirname(__FILE__), 'garmin', 'activity')
require File.join(File.dirname(__FILE__), 'garmin', 'track_point')
require File.join(File.dirname(__FILE__), 'garmin', 'tcx_parser')
require File.join(File.dirname(__FILE__), 'garmin', 'gpx_parser')

module Garmin
  TCX = 'tcx'
  GPX = 'gpx'
  
  def self.version
    "1.0"
  end

  def self.file_type(file_name)
    case File.extname(file_name).downcase
    when '.tcx'
      TCX
    when '.gpx'
      GPX
    else
      raise "Unknown filetype"
    end
  end

  def self.open(file_name)
    case file_type(file_name)
    when TCX
      Garmin::TcxParser.new(file_name)
    when GPX
      Garmin::GpxParser.new(file_name)
    end
  end
end
