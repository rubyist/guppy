require 'test/garmin_test_setup'

class TestTcxParser < Test::Unit::TestCase
  context "existance" do
    should "exist" do
      assert Garmin::TcxParser.new
    end
  end
end
