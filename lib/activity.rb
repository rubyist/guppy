module Garmin
  class Activity
    attr_accessor :sport
    attr_accessor :date
    attr_reader   :laps

    def initialize
      @laps = []
    end

    def distance
      laps.inject(0.0) { |sum, lap| sum + lap.distance }
    end
  end
end
