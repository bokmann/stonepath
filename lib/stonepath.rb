$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module StonePath
  # main hook into the framework.  From here, this should simply have methods that cause other includes to happen.
  def self.included(base)
  
    base.instance_eval {
  
      def stonepath_workitem(&config_block)
        require File.expand_path(File.dirname(__FILE__)) + "/stonepath/work_item.rb"
        include StonePath::WorkItem
        instance_eval &config_block if config_block
      end
    
      def stonepath_task(&config_block)
        require File.expand_path(File.dirname(__FILE__)) + "/stonepath/task.rb"
        include StonePath::SPTask
        instance_eval &config_block
      end
    
      def stonepath_workbench
        require File.expand_path(File.dirname(__FILE__)) + "/stonepath/work_bench.rb"
        include StonePath::WorkBench
      end
      
      def stonepath_workowner
        require File.expand_path(File.dirname(__FILE__)) + "/stonepath/work_owner.rb"
        include StonePath::WorkOwner
      end
    }
  end
  
end

require 'rubygems'
require 'active_record'
require "stonepath/config"

# I want to move these into init.rb, but for some reason, the way rails processes the
# init.rb chokes on load.  I suspect this is an artificial issue because of the way the
# embedded test app works.
load File.expand_path( File.dirname(__FILE__)) + '/stonepath/extensions/action_view.rb'




