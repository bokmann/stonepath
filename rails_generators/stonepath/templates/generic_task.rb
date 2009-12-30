class <%= args[0].classify %> < ActiveRecord::Base
  include StonePath
  
  stonepath_task
  
  #logs_transitions
  
end