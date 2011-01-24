class <%= class_name %> < ActiveRecord::Base
  include StonePath
   
  stonepath_workitem do
    #owned_by :your_owning class
  
    #tasked_through :your_implementation_of_stonepath_task
  
    # This is an example trivial workflow.  This is now yours to change as
    # you see fit.
    aasm_initial_state :pending
  
    aasm_state :pending
    aasm_state :in_process
    aasm_state :completed
  
    aasm_event :activate do
      transitions :to => :in_process, :from => :pending
    end
  
    aasm_event :complete do
      transitions :to => :completed, :from => :in_process
    end
  
    aasm_event :reactivate do
      transitions :to => :in_process, :from => :completed
    end
  
  end
  
  attr_accessible <%= attributes.map { |a| ":#{a.name}" }.join(", ") %>
  
end
