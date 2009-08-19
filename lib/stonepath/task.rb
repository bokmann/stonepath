module StonePath
  module SPTask
    def self.included(base)
      base.instance_eval do
        
        def assigns_to(workbench)
          belongs_to :assignee, :class_name => workbench.to_s.classify
        end
      
        def task_for(workitem)
          #belongs_to :workitem, :polymorphic => true
          belongs_to :workitem, :class_name => workitem.to_s.classify
        end
      
        def audits_transitions
          puts "#{self.class} audits transitions"
        end
                
        include AASM

        #we must be attached to a workitem.
        validates_presence_of :workitem
        
        # We can have unassigned tasks.
        #validates_presence_of :assignee
        
        aasm_initial_state :active


        aasm_state :active, :after_enter => :notify_created
        aasm_state :completed, :before_enter => :timestamp_complete, :after_enter => :notify_closed
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

        named_scope :unassigned, lambda { { :conditions => ['assignee_id IS NULL'] } }
        named_scope :active, lambda { { :conditions => ['aasm_state in (?)', ['active']] } }
        named_scope :overdue, lambda { { :conditions => ['aasm_state in (?) AND due_at < ?',  ['active'], Time.now] } }
        
        
      end
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