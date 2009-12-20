require File.dirname(__FILE__) + '/test_helper.rb'

class TaskTest < Test::Unit::TestCase

  def setup
  end
  
  should "create an assignment associated with a case" do
    c = Case.create
    c.assignments.create
    assert_equal(1, c.assignments.size, "Case should have 1 assignment")
  end
  
  should "have an initial state of active" do
    c = Case.create
    a = c.assignments.create
    assert_equal("active", a.aasm_state)
  end
  
  should "be able to complete an assignment" do
    c = Case.create
    a = c.assignments.create
    a.complete!
    assert_equal("completed", a.aasm_state)
  end
  
  should "be able to cancel an assignment" do
    c = Case.create
    a = c.assignments.create
    a.cancel!
    assert_equal("cancelled", a.aasm_state)
  end
  
  should "be able to expire an assignment" do
    c = Case.create
    a = c.assignments.create
    a.expire!
    assert_equal("expired", a.aasm_state)
  end
  
  should "be overdue? if due_at is in the past" do
     c = Case.create
     a = c.assignments.create(:due_at => 1.week.ago)
     assert(a.overdue?)
   end
   
  should "be able to set up the relationship between a case and an assignment" do
    c = Case.create
    a = c.assignments.create
    assert_equal(a, c.assignments[0])
    assert_equal(c, c.assignments[0].workitem)
  end
  
  should "be able to set up the relationship between a user (as a workbench) and an assignment" do
    u = User.create
    c = Case.create
    a = c.assignments.create(:workbench => u)
    
    assert_equal(a, u.assignments[0])
    assert_equal(u, a.workbench)
  end
end


