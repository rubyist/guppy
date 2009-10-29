require 'helper'

class TestGpxParser < Test::Unit::TestCase
  context "existence" do
    should "exist" do
      assert Guppy::GpxParser.new('foo.gpx')
    end
  end

  context "opening" do
    should "should create the tcx parser object" do
      flexmock(Guppy::TcxParser).should_receive(:new).with('foo.tcx').and_return(flexmock('parser', :parse => '')).once
      Guppy::TcxParser.open('foo.tcx')
    end

    should "parse the file" do
      parser = flexmock('parser')
      parser.should_receive(:parse).once
      flexmock(Guppy::TcxParser).should_receive(:new).and_return(parser)
      
      Guppy::TcxParser.open('foo.tcx')
    end

    should "return the TcxParser object" do
      parser = flexmock('parser', :parse => '')
      flexmock(Guppy::TcxParser).should_receive(:new).with('foo.tcx').and_return(parser)

      assert_equal parser, Guppy::TcxParser.open('foo.tcx')
    end
  end
end
