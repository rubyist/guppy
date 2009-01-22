require 'rubygems'
require 'nokogiri'

module Garmin
  class TcxParser
    def initialize(file)
      @file = file
    end

    def parse
      f = File.open(@file)
      doc = Nokogiri.XML(f.read)

      f.close
    end
  end
end
