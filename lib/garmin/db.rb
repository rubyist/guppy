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
      db = new(file_name)
      db.parse
      return db
    end

    def initialize(file)
      @file_name = file
    end
    
    def parse
      case self.class.file_type(@file_name)
      when TCX
        @doc = Garmin::TcxParser.new(@file_name)
      when GPX
        @doc = Garmin::GpxParser.new(@file_name)
      end
    end
  end
end

# Db.open('file') => chooses parser, parses, new db
