require 'helper'

class TestGuppy < Test::Unit::TestCase
  context "methods" do
    should "have a version" do
      assert Guppy.version
    end
  end

end
