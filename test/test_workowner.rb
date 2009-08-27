require File.dirname(__FILE__) + '/test_helper.rb'

class TestWorkowner < Test::Unit::TestCase

  def setup
  end
  
  should "include the WorkOwner module when declared as a stonepath_workowner" do
    assert Workowner.included_modules.include?(StonePath::WorkOwner)
  end
  
  should "create a new user successfully" do
    u = User.create
  end
end


class Workowner < ActiveRecord::Base
  include StonePath
  
  stonepath_workowner
  
  workowner_for :work_items
  
end