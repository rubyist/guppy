module Garmin
  class Db
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
end
