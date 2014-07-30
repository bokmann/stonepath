require File.dirname(__FILE__) + '/test_helper.rb'

class WorkitemTest < Test::Unit::TestCase

  def setup
  end
  
  should "not do much of anything yet" do
    c = Case.new
  end
  
  should "contain xml for the possible events" do
    c = Case.create
    xml = c.to_xml
    assert(xml.include?("<aasm_events_for_current_state type=\"array\">"))
  end
end
