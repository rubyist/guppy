module Guppy
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

      activity_node.xpath('xmlns:Lap', namespaces).each do |lap_node|
        activity.laps << build_lap(lap_node)
      end
      
      activity
    end

    def build_lap(lap_node)
      lap = Guppy::Lap.new
      lap.distance = lap_node.xpath('xmlns:DistanceMeters', namespaces).inner_text.to_f
      lap.max_speed = lap_node.xpath('xmlns:MaximumSpeed', namespaces).inner_text.to_f
      lap.time = lap_node.xpath('xmlns:TotalTimeSeconds', namespaces).inner_text.to_f
      lap.calories = lap_node.xpath('xmlns:Calories', namespaces).inner_text.to_f
      lap.average_heart_rate = lap_node.xpath('xmlns:AverageHeartRateBpm/xmlns:Value', namespaces).inner_text.to_i
      lap.max_heart_rate = lap_node.xpath('xmlns:MaximumHeartRateBpm/xmlns:Value', namespaces).inner_text.to_i

      lap_node.xpath('xmlns:Track/xmlns:Trackpoint', namespaces).each do |track_point_node|
        lap.track_points << build_track_point(track_point_node)
      end
      
      lap
    end

    def build_track_point(track_point_node)
      track_point = Guppy::TrackPoint.new
      track_point.latitude = track_point_node.xpath('xmlns:Position/xmlns:LatitudeDegrees', namespaces).inner_text.to_f
      track_point.longitude = track_point_node.xpath('xmlns:Position/xmlns:LongitudeDegrees', namespaces).inner_text.to_f
      track_point.altitude = track_point_node.xpath('xmlns:AltitudeMeters', namespaces).inner_text.to_f
      track_point.distance = track_point_node.xpath('xmlns:DistanceMeters', namespaces).inner_text.to_f
      track_point.heart_rate = track_point_node.xpath('xmlns:HeartRateBpm/xmlns:Value', namespaces).inner_text.to_i
      track_point.time = Time.parse(track_point_node.xpath('xmlns:Time', namespaces).inner_text)
      
      track_point
    end
    
    def namespaces
      @namespaces ||= @doc.root.namespaces
    end
  end
end
