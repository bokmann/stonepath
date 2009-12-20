class Assignment < ActiveRecord::Base
  include StonePath
  
  stonepath_task
  
  task_for :case
  
  audits_transitions
  
end
