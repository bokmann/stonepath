class CustomAssignment < ActiveRecord::Base
  set_table_name "assignments"
  include StonePath
  
  stonepath_task do
    aasm_initial_state :active
    aasm_state :active, :after_enter => :notify_created
    aasm_state :escalated
    aasm_state :completed, :before_enter => :timestamp_complete, :after_enter => :notify_closed

    aasm_event :complete do
      transitions :to => :completed, :from => [:active, :escalated]
    end

    aasm_event :escalate do
      transitions :to => :escalated, :from => :active
    end
  end
  
  
end
