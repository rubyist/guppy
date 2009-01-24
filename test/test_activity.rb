require 'test/garmin_test_setup'

class TestActivity < Test::Unit::TestCase
  should "have a date" do
    a = Garmin::Activity.new
    t = Time.now
    a.date = t
    assert_equal t, a.date
  end
  
  should "have a distance" do
    a = Garmin::Activity.new
    a.laps << flexmock('lap', :distance => 325.5)
    assert_equal 325.5, a.distance
  end

  should "have laps" do
    a = Garmin::Activity.new
    assert_equal [], a.laps
  end
end
