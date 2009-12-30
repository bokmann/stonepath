# The WorkItem is the center of this framework.  It is the thing that has a workflow,
# is the subject of ownership and tasks.  Tis is the place the primaey state machine will
# exist

module StonePath
  module WorkItem
    def self.included(base)
      base.instance_eval do
        include AASM
        
        require File.expand_path(File.dirname(__FILE__)) + "/event_logging.rb"
        extend StonePath::EventLogging
        
        def owned_by(owner, options={})
          options.merge!(:class_name => owner.to_s.classify)
          belongs_to :owner, options
        end
        
        def tasked_through(tasks, options={})
          has_many tasks, :as => :workitem
        end
        
        def stonepath_acl()
          require File.expand_path(File.dirname(__FILE__)) + "/acl.rb"
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
      end #base.instance_eval

      def allowed?(method)
        acl.allowed?(aasm_current_state, current_user, method)
      end
      
      # modifies to_xml do that it includes all the possible events from this state.
      # useful when you are using WorkItems as resources with ActiveResource
      def to_xml_with_events
        to_xml_without_events do |xml|
          xml.aasm_events_for_current_state(:type=>"array") do
            aasm_events_for_current_state.each do |e|
              xml.aasm_event do
                xml.name e.to_s
              end
            end
          end
        end
      end
      
      base.instance_eval do
        alias_method_chain :to_xml, :events      
      end
      
    end #self.included
    
  end
end