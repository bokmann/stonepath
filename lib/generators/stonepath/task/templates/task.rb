class <%= class_name %> < ActiveRecord::Base
  include StonePath
  
  # prior to stonepath 0.6.2, this definition of task was defined as a 'default' deep
   # inside of the code to the gem.  This created two problems:
   #  1- users of the framework didn't realize this was their behavior to change/redefine
   #  2- the way the reused block was defined broke in ruby 1.9.2
   #
   # Putting this in the generated template both solvs the 1.9.2 problem *and* makes it clear 
   # to end users that this is your behavior to modify as you see fit.
   #
   # the default workflow for tasks (upon generation) is:
   #   [active] -{complete}-> [completed]
   #            -{expire}-> [expired]
   #            -{cancel}-> [cancelled]
   #
   # you are free to modify that to suit your domain.
   stonepath_task do
     aasm_initial_state :active
     aasm_state :active, :after_enter => :notify_created
     aasm_state :completed, :enter => :timestamp_complete, :after_enter => :notify_closed

     aasm_state :expired, :after_enter => :notify_closed
     aasm_state :cancelled, :after_enter => :notify_closed

     aasm_event :complete do
      transitions :to => :completed, :from => :active
     end

     aasm_event :cancel do
      transitions :to => :cancelled, :from => [:active, :completed]
     end

     aasm_event :expire do
      transitions :to => :expired, :from => :active
     end

     scope :unassigned, { :conditions => ['workbench_id IS NULL'] }
     scope :assigned, { :conditions => ['workbench_id IS NOT NULL'] }
     scope :active, { :conditions => ['aasm_state in (?)', ['active']] }
     scope :completed, { :conditions => ['aasm_state in (?)', ['completed']] }
     scope :expired, { :conditions => ['aasm_state in (?)', ['expired']] }
     scope :cancelled, { :conditions => ['aasm_state in (?)', ['cancelled']] }
     scope :overdue, lambda { { :conditions => ['aasm_state in (?) AND due_at < ?',  ['active'], Time.now] } }
   end
  
  # You can log events on Tasks by running the event log generator and uncommenting this line.
  #log_events
  
  attr_accessible :workitem, :workbench <% unless attributes.empty? %>, <% end %> <%= attributes.map { |a| ":#{a.name}" }.join(", ") %>
  
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
    (Time.now > due_at) && self.active?
  end
  
  private
  
  def timestamp_complete
    self.completed_at = Time.now
  end
  
end