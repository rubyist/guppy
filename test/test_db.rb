require 'helper'

class TestDb < Test::Unit::TestCase
  context "exist" do
    should "exist" do
      assert Guppy::Db.new('file.tcx')
    end
  end
  context "determining file type" do
    should "determine tcx for files with a tcx extension" do
      assert_equal Guppy::TCX, Guppy::Db.file_type("foo.tcx")
    end

    should "determin gpx for files with a gpx extension" do
      assert_equal Guppy::GPX, Guppy::Db.file_type("foo.gpx")
    end

    should "raise an exception if it can't determine the type" do
      assert_raise RuntimeError do
        Guppy::Db.file_type('foobar')
      end
    end
  end

  context "opening database files" do
    should "create a new Db object" do
      flexmock(Guppy::Db).should_receive(:new).with('foo.tcx').and_return(flexmock('db', :parse => '')).once

      Guppy::Db.open('foo.tcx')
    end
    
    should "parse it" do
      db = flexmock('db')
      db.should_receive(:parse).once
      
      flexmock(Guppy::Db).should_receive(:new).with('foo.tcx').and_return(db)

      Guppy::Db.open('foo.tcx')
    end
    
    should "return the Db object" do
      db = flexmock('db', :parse => '')
      flexmock(Guppy::Db).should_receive(:new).with('foo.tcx').and_return(db)
      
      assert_equal db, Guppy::Db.open('foo.tcx')
    end
  end

  context "parsing" do
    should "use TcxParser for tcx files" do
      flexmock(Guppy::TcxParser).should_receive(:open).with('foo.tcx').once
      Guppy::Db.new('foo.tcx').parse
    end

    should "use GpxParser for gpx files" do
      flexmock(Guppy::GpxParser).should_receive(:open).with('foo.gpx').once
      Guppy::Db.new('foo.gpx').parse
    end
  end

  context "activities" do
    should "have one activity" do
      db = Guppy::Db.open(tcx_fixture_file)
      assert_equal 1, db.activities.size
    end

    should "find an activity" do
      db = Guppy::Db.open(tcx_fixture_file)
      assert db.activity('2009-01-12T19:28:18Z')
    end
  end
end
