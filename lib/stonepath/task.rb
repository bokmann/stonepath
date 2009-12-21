# A Task in this framework is simply a relation between a workitem and a workbench.  It has
# some default workflow, and should be extended with whatever attributes make sense for the
# business domain you are modeling.

module StonePath
  module SPTask
    
    # This will move from here shortly, into another class/module for containing things like this.
    # This is the workflow definition for a default task.  This is defined this way so that users
    # can provide their own task workflow definition as a block to the stonepath_task declaration.
    # This lanbda is passed in if the user doesn't provide anything.
    # It is possible that we will identify other useful options and want to provide them as config
    # blocks in the StonePath gem.
    def self.default_config_block
      lambda {
        aasm_initial_state :active
        aasm_state :active, :after_enter => :notify_created
        aasm_state :completed, :after_enter => [:timestamp_complete, :notify_closed]
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

        named_scope :unassigned, { :conditions => ['assignee_id IS NULL'] }
        named_scope :assigned, { :conditions => ['assignee_id IS NOT NULL'] }
        named_scope :active, { :conditions => ['aasm_state in (?)', ['active']] }
        named_scope :completed, { :conditions => ['aasm_state in (?)', ['completed']] }
        named_scope :expired, { :conditions => ['aasm_state in (?)', ['expired']] }
        named_scope :cancelled, { :conditions => ['aasm_state in (?)', ['cancelled']] }
        named_scope :overdue, lambda { { :conditions => ['aasm_state in (?) AND due_at < ?',  ['active'], Time.now] } }
      }
    end
    
    
    def self.included(base)
      base.instance_eval do
      
        # Tasks are now completely polymorphic between workbenches.
        # as long as an activerecord model declares itself as a workbench and declares itself
        # a workbench for the specific kind of task, everything just works.
        belongs_to :workbench, :polymorphic => true
        
        # Tasks are now completely polymorphic between workitems.
        # as long as an activerecord model declares itself as a workitem and declares itself
        # a workitem for the specific kind of task, everything just works.
        belongs_to :workitem, :polymorphic => true
        
        def audits_transitions
          puts "#{self.class} audits transitions"
        end
                
        include AASM
        
      end
    end
    
    def overdue?
      return false if due_at.nil?
      due_at < Time.now  
    end
    
    private
    
    def timestamp_complete
      self.completed_at = Time.now
    end
    
    def notify_created
      if workitem.respond_to?(:task_created)
        workitem.task_created(self)
      end
    end
    
    def notify_closed
      if workitem.respond_to?(:task_closed)
        workitem.task_closed(self)
      end
    end

  end
end