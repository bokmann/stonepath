class <%= class_name %> < ActiveRecord::Base
  include StonePath
  
  stonepath_task
  
  #log_events  # uncomment this if you generate the event log.
  
  attr_accessible :workitem, :workbench, <%= attributes.map { |a| ":#{a.name}" }.join(", ") %>
  
  # you might think 'overdue' should be a state, but no, part of the stonepath
  # methodology is that states should be as free of time definition as possible.
  # Thinking about it, this should make sense.  Think of the conversation:
  # A:  "That isn't done yet?"
  # B:  "No, it's overdue"
  # A:  "Well, where is it then?"
  # B:  "It's still on Mike's desk, in process".
  #
  # so the state would be 'in process', even though it is 'overdue'.
  def overdue?
    (Time.now > due_at) && !self.completed?
  end
  
end