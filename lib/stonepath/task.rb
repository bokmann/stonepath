module StonePath
  module SPTask
    
    def self.default_config_block
      lambda {
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
      
        belongs_to :assignee, :polymorphic => true
        
        def task_for(workitem, options={})
          options.merge!(:class_name => workitem.to_s.classify)
          belongs_to :workitem, options
        end
      
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