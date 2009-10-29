module Garmin
  class GpxParser
    def self.open(file)
      parser = self.new(file)
      parser.parse
      parser
    end

    def initialize(file)
      @file = file
    end

    def parse
    end
  end
end
