require 'helper'

class TestGpxParser < Test::Unit::TestCase
  context "existence" do
    should "exist" do
      assert Garmin::GpxParser.new('foo.gpx')
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
end
