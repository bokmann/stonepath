require File.dirname(__FILE__) + '/test_helper.rb'

class CustomTaskTest < Test::Unit::TestCase

  def setup
  end
  
  should "be able to create a custom assignment" do
    ca = CustomAssignment.create
    assert(ca.id != nil)
  end
  
  should "be able to escalate a custom assignment" do
    ca = CustomAssignment.create
    ca.escalate!
    assert_equal("escalated", ca.aasm_state)
  end
  
  should "be able to complete a custom assignment" do
    ca = CustomAssignment.create
    ca.complete!
    assert_equal("completed", ca.aasm_state)
  end
  
end


