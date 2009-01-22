require 'test/garmin_test_setup'

class TestGarmin < Test::Unit::TestCase
  context "methods" do
    should "have a version" do
      assert Garmin.version
    end
  end

  context "determining file type" do
    should "determine tcx for files with a tcx extension" do
      assert_equal Garmin::TCX, Garmin.file_type("foo.tcx")
    end

    should "determin gpx for files with a gpx extension" do
      assert_equal Garmin::GPX, Garmin.file_type("foo.gpx")
    end

    should "raise an exception if it can't determine the type" do
      assert_raise RuntimeError do
        Garmin.file_type('foobar')
      end
    end
  end

  context "opening database files" do
    should "use TcxParser for tcx files" do
      flexmock(Garmin::TcxParser).should_receive(:new).with('foo.tcx').once
      Garmin.open('foo.tcx')
    end

    should "use GpxParser for gpx files" do
      flexmock(Garmin::GpxParser).should_receive(:new).with('foo.gpx').once
      Garmin.open('foo.gpx')
    end
  end
end
