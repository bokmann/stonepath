require File.dirname(__FILE__) + '/test_helper.rb'


  
class TestRole < Test::Unit::TestCase

  def setup
  end
  
  should "include the Role module when declared as a stonepath_role" do
    assert Role.included_modules.include?(StonePath::Role)
  end
end


class Role
  include StonePath
  
  stonepath_role
end