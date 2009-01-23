require 'test/garmin_test_setup'

class TestGarmin < Test::Unit::TestCase
  context "methods" do
    should "have a version" do
      assert Garmin.version
    end
  end

end
