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
      f = File.open(@file)
      @doc = Nokogiri.XML(f.read)
      f.close
    end

    def activity(activity_id)
      acticity_node = @doc.xpath('//xmlns:trk', namespaces).find do |a|
        a.xpath('xmlns:name', namespaces).inner_text == activity_id
      end
      if activity_node
        build_activity(activity_node)
      else
        nil
      end
    end

    def activities
      @doc.xpath('//xmlns:trk', namespaces).map do |activity_node|
        build_activity(activity_node)
      end
    end

    private
    def build_activity(activity_node)
      activity = Activity.new
      activity_node.xpath('xmlns:trkseg', namespaces).each do |lap_node|
        activity.laps << build_lap(lap_node)
      end
      activity
    end

    def build_lap(lap_node)
      lap = Garmin::Lap.new
      total_distance = 0.0
      lap_node.xpath('xmlns:trkpt', namespaces).each do |track_point_node|
        track_point = build_track_point(track_point_node, total_distance)
        lap.track_points << track_point
        total_distance += track_point.distance
      end
      lap.distance = total_distance
      lap
    end

    def build_track_point(track_point_node, total_distance)
      track_point = Garmin::TrackPoint.new
      track_point.latitude = track_point_node['lat'].to_f
      track_point.longitude = track_point_node['lon'].to_f
      track_point.altitude = track_point_node.xpath('xmlns:ele', namespaces).inner_text.to_f
      track_point.time = Time.parse(track_point_node.xpath('xmlns:time', namespaces).inner_text)
      # GPX distance is cumulative
      d = track_point_node.xpath('xmlns:extensions/gpxdata:distance').inner_text.to_f
      tp_distance = d - total_distance
      track_point.distance = tp_distance > 0.0 ? tp_distance : 0.0
      
      track_point
    end

    def namespaces
      @namespaces ||= @doc.root.namespaces
    end
  end
end
