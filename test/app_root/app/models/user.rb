class User < ActiveRecord::Base
  include StonePath
  include SentientUser
    
  stonepath_workowner
  workowner_for :case
  
  stonepath_workbench
  workbench_for :assignments
  
end
