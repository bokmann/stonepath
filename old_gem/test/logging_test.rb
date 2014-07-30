require File.dirname(__FILE__) + '/test_helper.rb'

class LoggingTest < Test::Unit::TestCase

  def setup
  end
  
  should "not have any log entries for a new case" do
    c = Case.create
    assert_equal(0, c.logged_events.size)
  end
  
  should "log when a transition happens" do
    c = Case.create
    assert_equal(0, c.logged_events.size)
    c.activate!
    assert_equal(1, c.logged_events.size)
    assert_equal("activate", c.logged_events[0].event_name)
    assert_equal("pending", c.logged_events[0].old_state_name)
    assert_equal("in_process", c.logged_events[0].new_state_name)
    
    c.complete!
    assert_equal(2, c.logged_events.size)
    assert_equal("complete", c.logged_events[1].event_name)
    assert_equal("in_process", c.logged_events[1].old_state_name)
    assert_equal("completed", c.logged_events[1].new_state_name)
  end
end
