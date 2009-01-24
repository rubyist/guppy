require 'test/garmin_test_setup'

class TestTcxParser < Test::Unit::TestCase
  context "existance" do
    should "exist" do
      assert Garmin::TcxParser.new('foo.tcx')
    end
  end

  context "opening" do
    should "should create the tcx parser object" do
      flexmock(Garmin::TcxParser).should_receive(:new).with('foo.tcx').and_return(flexmock('parser', :parse => '')).once
      Garmin::TcxParser.open('foo.tcx')
    end

    should "parse the file" do
      parser = flexmock('parser')
      parser.should_receive(:parse).once
      flexmock(Garmin::TcxParser).should_receive(:new).and_return(parser)
      
      Garmin::TcxParser.open('foo.tcx')
    end

    should "return the TcxParser object" do
      parser = flexmock('parser', :parse => '')
      flexmock(Garmin::TcxParser).should_receive(:new).with('foo.tcx').and_return(parser)

      assert_equal parser, Garmin::TcxParser.open('foo.tcx')
    end
  end

  context "parsing" do
    setup do
      @parser = Garmin::TcxParser.new('foo.tcx')
    end
    
    should "open the file" do
      flexmock(File).should_receive(:open).with('foo.tcx').and_return(flexmock('file', :read => '', :close => '')).once

      @parser.parse
    end

    should "read the file" do
      file = flexmock('file', :close => '')
      file.should_receive(:read).once
      
      flexmock(File).should_receive(:open).with('foo.tcx').and_return(file)

      @parser.parse
    end

    should "pass the file data into nokogiri" do
      flexmock(File).should_receive(:open).with('foo.tcx').and_return(flexmock('file', :read => 'xml data', :close => ''))

      flexmock(Nokogiri).should_receive(:XML).with('xml data').once

      @parser.parse
    end

    should "close the file handle" do
      file = flexmock('file', :read => '')
      file.should_receive(:close).once
      
      flexmock(File).should_receive(:open).with('foo.tcx').and_return(file)

      @parser.parse
    end
  end

  context "finding all activities" do
    setup do
      @p = Garmin::TcxParser.new(tcx_fixture_file)
      @p.parse
    end
    
    should "find the activities" do
      assert_equal 1, @p.activities.size
    end

    should "create Activity objects" do
      assert @p.activities.first.is_a?(Garmin::Activity), "Expected an Activity, got a #{@p.activities.first.class}"
    end

    should "give the Activity objects a sport property" do
      assert_equal "Running", @p.activities.first.sport
    end

    should "give the Activity objects a date" do
      assert_equal Time.parse('2009-01-12T19:28:18Z'), @p.activities.first.date
    end

    should "give the Activity objects a distance" do
      assert_equal 1609.3439941, @p.activities.first.distance
    end
  end

  context "finding a specific activity" do
    setup do
      @p = Garmin::TcxParser.new(tcx_fixture_file)
      @p.parse
    end
    
    should "return an activity" do
      assert @p.activity('2009-01-12T19:28:18Z').is_a?(Garmin::Activity)
    end

    should "return nil if the activity was not found" do
      assert_nil @p.activity('2009-01-12T19:27:18Z')
    end

    should "build the activity" do
      flexmock(@p).should_receive(:build_activity).once

      @p.activity('2009-01-12T19:28:18Z')
    end
  end

  context "building Laps" do
    setup do
      @p = Garmin::TcxParser.new(tcx_fixture_file)
      @p.parse
      @activity = @p.activities.first
    end

    should "build the Lap" do
      assert_equal 1, @activity.laps.size
    end

    should "have the right distance on the lap" do
      assert_equal 1609.3439941, @activity.laps.first.distance
    end

    should "have the max speed on the lap" do
      assert_equal 3.4845836, @activity.laps.first.max_speed
    end

    should "have the time on the lap" do
      assert_equal 641.43, @activity.laps.first.time
    end

    should "have the calories on the lap" do
      assert_equal 170, @activity.laps.first.calories
    end

    should "have the average heart rate on the lap" do
      assert_equal 184, @activity.laps.first.average_heart_rate
    end

    should "have the max hart rate on the lap" do
      assert_equal 196, @activity.laps.first.max_heart_rate
    end
  end

  context "building TrackPoints" do
    setup do
      @p = Garmin::TcxParser.new(tcx_fixture_file)
      @p.parse
      @lap = @p.activities.first.laps.first
    end
    
    should "build the track points" do
      assert_equal 1, @lap.track_points.size
    end

    should "have a latitude" do
      assert_equal 37.1057968, @lap.track_points.first.latitude
    end

    should "have a longitude" do
      assert_equal -80.5901920,  @lap.track_points.first.longitude
    end

    should "have an altitude" do
      assert_equal 253.9254150,  @lap.track_points.first.altitude
    end

    should "have a heart rate" do
      assert_equal 130, @lap.track_points.first.heart_rate
    end

    should "have a distance" do
      assert_equal 3.141, @lap.track_points.first.distance
    end

    should "have a time" do
      assert_equal Time.parse('2009-01-12T19:28:18Z'), @lap.track_points.first.time
    end
  end
end
