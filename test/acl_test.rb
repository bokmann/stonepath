require File.dirname(__FILE__) + '/test_helper.rb'


  
class TestACL < Test::Unit::TestCase

  def setup
  end
  
  context "our sample rails app" do
    
    should "include the Group module when declared as a stonepath_group" do
      assert true
    end
  
  end
end
