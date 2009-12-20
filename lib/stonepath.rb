$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module StonePath
  # main hook into the framework.  From here, this should simply have methods that cause other includes to happen.
  def self.included(base)
  
    base.instance_eval {
  
      def stonepath_workitem
        require File.expand_path(File.dirname(__FILE__)) + "/stonepath/work_item.rb"
        include StonePath::WorkItem
      end
    
      def stonepath_task(&config_block)
        require File.expand_path(File.dirname(__FILE__)) + "/stonepath/task.rb"
        include StonePath::SPTask
      end
    
      def stonepath_workbench
        require File.expand_path(File.dirname(__FILE__)) + "/stonepath/work_bench.rb"
        include StonePath::WorkBench
      end
    
      def stonepath_group
        require File.expand_path(File.dirname(__FILE__)) + "/stonepath/group.rb"
        include StonePath::Group
      end
    
      def stonepath_role
        require File.expand_path(File.dirname(__FILE__)) + "/stonepath/role.rb"
        include StonePath::Role
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

load File.expand_path( File.dirname(__FILE__)) + "/stonepath/extensions/activerecordbase.rb"
require "stonepath/config"


