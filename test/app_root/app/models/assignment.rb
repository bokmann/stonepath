class Assignment < ActiveRecord::Base
  include StonePath
  
  stonepath_task
  
  task_for :case
  assigns_to :user
  
  audits_transitions
  
end
