require 'test/garmin_test_setup'

class TestGpxParser < Test::Unit::TestCase
  context "existence" do
    should "exist" do
      assert Garmin::GpxParser.new
    end
  end
end
