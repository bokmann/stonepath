class Assignment < ActiveRecord::Base
  include StonePath
  
  stonepath_task
  
  logs_transitions
  
end
