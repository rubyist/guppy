require 'test/garmin_test_setup'

class TestTcxParser < Test::Unit::TestCase
  context "existance" do
    should "exist" do
      assert Garmin::TcxParser.new('foo.tcx')
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
end
