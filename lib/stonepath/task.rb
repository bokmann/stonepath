# A Task in this framework is simply a relation between a workitem and a workbench.  It has
# some default workflow, and should be extended with whatever attributes make sense for the
# business domain you are modeling.

module StonePath
  module SPTask
      
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
        
        require File.expand_path(File.dirname(__FILE__)) + "/dot.rb"
        extend StonePath::Dot
        
      end
    end
    
    private
    
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