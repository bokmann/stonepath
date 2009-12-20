module StonePath
  module WorkItem
    def self.included(base)
      base.instance_eval do
        include AASM
        
        def owned_by(owner, options={})
          options.merge!(:class_name => owner.to_s.classify)
          belongs_to :owner, options
        end
        
        def subject_of(tasks, options={})
          has_many tasks, options
        end
        
        def stonepath_acl()
          require File.expand_path(File.dirname(__FILE__)) + "/acl.rb"
          #require File.expand_path(File.dirname(__FILE__)) + "/acl/acl.rb"
          #require File.expand_path(File.dirname(__FILE__)) + "/acl/acl_role.rb"
          #require File.expand_path(File.dirname(__FILE__)) + "/acl/acl_state.rb"
          cattr_accessor :acl
          self.acl = StonePath::ACL::Controller.new(self)
          yield self.acl
        end
        
        def self.define_attribute_methods_with_hook
          define_attribute_methods_without_hook
          acl.fix_aliases if defined? self.acl
        end
        
        class << self
          alias_method "define_attribute_methods_without_hook", "define_attribute_methods"
          alias_method "define_attribute_methods", "define_attribute_methods_with_hook"
        end
      end
      
      def allowed?(method)
        acl.allowed?(aasm_current_state, current_user, method)
      end
      
    end
  end
end


# if table_exists? <workitem>_transition_log_entries
#define  WorkItem::TransitionLogEntry
# then for each transition method, have an after proc that
# creates workitem_transition_log
# workitem_id
# transitioned_to
# transitioned_by
# transitioned_at