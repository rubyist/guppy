require 'helper'

class TestTrackPoint < Test::Unit::TestCase
  context "setup" do
    should "should have a latitude" do
      tp = Guppy::TrackPoint.new
      tp.latitude = 39.1057968
      assert_equal 39.1057968, tp.latitude
    end

    should "have a longitude" do
      tp = Guppy::TrackPoint.new
      tp.longitude = -84.5902028
      assert_equal(-84.5902028, tp.longitude)
    end
    
    should "have an altitude" do
      tp = Guppy::TrackPoint.new
      tp.altitude = 254.4060059
      assert_equal 254.4060059, tp.altitude
    end
    
    should "have a heart rate" do
      tp = Guppy::TrackPoint.new
      tp.heart_rate = 90
      assert_equal 90, tp.heart_rate
    end
    
    should "have a time" do
      t = Time.now
      tp = Guppy::TrackPoint.new
      tp.time = t
      assert_equal t, tp.time
    end
    
    should "have a distance" do
      tp = Guppy::TrackPoint.new
      tp.distance = 234.4523
      assert_equal 234.4523, tp.distance
    end
  end
end
