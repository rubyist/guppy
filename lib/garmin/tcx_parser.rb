require 'rubygems'
require 'nokogiri'
require 'time'

module Garmin
  class TcxParser
    def self.open(file)
      parser = self.new(file)
      parser.parse
      parser
    end

    def initialize(file)
      @file = file
    end

    def parse
      f = File.open(@file)
      @doc = Nokogiri.XML(f.read)
      f.close
    end

    def activities
      @doc.xpath('//xmlns:Activity', @doc.root.namespaces).map do |xml_activity|
        activity = Activity.new
        activity.sport = xml_activity['Sport']
        activity.date = Time.parse(xml_activity.xpath('xmlns:Id', @doc.root.namespaces).inner_text)

        activity.distance = xml_activity.xpath('xmlns:Lap', @doc.root.namespaces).inject(0.0) do |sum, acc|
          sum + acc.xpath('xmlns:DistanceMeters', @doc.root.namespaces).inner_text.to_f
        end
        
        activity
      end
    end
  end
end
