class Case < ActiveRecord::Base
  include StonePath
  
  stonepath_workitem do
  
    log_events
  
    aasm_initial_state :pending

    aasm_state :pending
    aasm_state :in_process
    aasm_state :completed

    aasm_event :complete do
      transitions :to => :completed, :from => :in_process
    end

    aasm_event :activate do
      transitions :to => :in_process, :from => :pending
    end
  
    owned_by :user
    tasked_through :assignments
   end
   
   def task_created(task)
     self.notification_method = "created"
     self.notified_id = task.id
     self.save
   end
   
   def task_closed(task)
     self.notification_method = "closed"
     self.notified_id = task.id
     self.save
   end

end
