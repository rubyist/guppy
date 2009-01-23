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

    def activity(activity_id)
      activity_node = @doc.xpath('//xmlns:Activity', namespaces).find {|a| a.xpath('xmlns:Id', namespaces).inner_text == activity_id}
      if activity_node
        build_activity(activity_node)
      else
        nil
      end
    end
    
    def activities(id=nil)
      @doc.xpath('//xmlns:Activity', namespaces).map do |activity_node|
        build_activity(activity_node)
      end
    end

    private
    def build_activity(activity_node)
      activity = Activity.new
      activity.sport = activity_node['Sport']
      activity.date = Time.parse(activity_node.xpath('xmlns:Id', namespaces).inner_text)
      
      activity.distance = activity_node.xpath('xmlns:Lap', namespaces).inject(0.0) do |sum, acc|
        sum + acc.xpath('xmlns:DistanceMeters', namespaces).inner_text.to_f
      end
      
      activity
    end

    def namespaces
      @namespaces ||= @doc.root.namespaces
    end
  end
end
