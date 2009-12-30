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

        named_scope :unassigned, { :conditions => ['workbench_id IS NULL'] }
        named_scope :assigned, { :conditions => ['workbench_id IS NOT NULL'] }
        named_scope :active, { :conditions => ['aasm_state in (?)', ['active']] }
        named_scope :completed, { :conditions => ['aasm_state in (?)', ['completed']] }
        named_scope :expired, { :conditions => ['aasm_state in (?)', ['expired']] }
        named_scope :cancelled, { :conditions => ['aasm_state in (?)', ['cancelled']] }
        named_scope :overdue, lambda { { :conditions => ['aasm_state in (?) AND due_at < ?',  ['active'], Time.now] } }
      }
    end
    
    
    def self.included(base)
      base.instance_eval do
        include AASM
      
        # Tasks are now completely polymorphic between workbenches.
        # as long as an activerecord model declares itself as a workbench and declares itself
        # a workbench for the specific kind of task, everything just works.
        belongs_to :workbench, :polymorphic => true
        
        # Tasks are now completely polymorphic between workitems.
        # as long as an activerecord model declares itself as a workitem and declares itself
        # a workitem for the specific kind of task, everything just works.
        belongs_to :workitem, :polymorphic => true
        
        #add the ability to log events if the user so specifies
        require File.expand_path(File.dirname(__FILE__)) + "/event_logging.rb"
        extend StonePath::EventLogging
        
      end
    end
    
    # I don't think this should really be part of Stonepath, but I'm adding it here as a comment
    # to communicate some design intent to my fellow teammembers on a project using stonepath.
    # For the 'timely|imminent|overdue' stuff, at the time the task is created, we would need to
    # set and calculate the imminent_at and due_at times. These methods would then do what
    # we need them to do.
    # def imminent?
    #   return false if imminent_at.nil?
    #   imminent_at < Time.now  
    # end
    #
    # we might also want this method, which would be useful in css styling
    # def timeliness
    #   return "overdue" if overdue?
    #   return "imminent" if imminent?
    #   return "timely"
    # end
    
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