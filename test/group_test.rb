require File.dirname(__FILE__) + '/test_helper.rb'


  
class TestGroup < Test::Unit::TestCase

  def setup
  end
  
  should "include the Group module when declared as a stonepath_group" do
    assert Group.included_modules.include?(StonePath::Group)
  end
end


class Group
  include StonePath
  
  stonepath_group
end