require 'test/garmin_test_setup'

class TestDb < Test::Unit::TestCase
  context "exist" do
    should "exist" do
      assert Garmin::Db.new('file.tcx')
    end
  end
  context "determining file type" do
    should "determine tcx for files with a tcx extension" do
      assert_equal Garmin::TCX, Garmin::Db.file_type("foo.tcx")
    end

    should "determin gpx for files with a gpx extension" do
      assert_equal Garmin::GPX, Garmin::Db.file_type("foo.gpx")
    end

    should "raise an exception if it can't determine the type" do
      assert_raise RuntimeError do
        Garmin::Db.file_type('foobar')
      end
    end
  end

  context "opening database files" do
    should "create a new Db object" do
      flexmock(Garmin::Db).should_receive(:new).with('foo.tcx').and_return(flexmock('db', :parse => '')).once

      Garmin::Db.open('foo.tcx')
    end
    
    should "parse it" do
      db = flexmock('db')
      db.should_receive(:parse).once
      
      flexmock(Garmin::Db).should_receive(:new).with('foo.tcx').and_return(db)

      Garmin::Db.open('foo.tcx')
    end
    
    should "return the Db object" do
      db = flexmock('db', :parse => '')
      flexmock(Garmin::Db).should_receive(:new).with('foo.tcx').and_return(db)
      
      assert_equal db, Garmin::Db.open('foo.tcx')
    end
  end

  context "parsing" do
    should "use TcxParser for tcx files" do
      flexmock(Garmin::TcxParser).should_receive(:open).with('foo.tcx').once
      Garmin::Db.new('foo.tcx').parse
    end

    should "use GpxParser for gpx files" do
      flexmock(Garmin::GpxParser).should_receive(:open).with('foo.gpx').once
      Garmin::Db.new('foo.gpx').parse
    end
  end

  context "activities" do
    should "have one activity" do
      db = Garmin::Db.open(tcx_fixture_file)
      assert_equal 1, db.activities.size
    end
  end
end
