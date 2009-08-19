module StonePath
  module ACL
    class Controller

      attr_reader :guarded_class_methods
      attr_reader :guarded_instance_methods
      attr_reader :states
      attr_reader :guarded_class
      attr_reader :method_groups



      def initialize(guarded_class)
        @guarded_class = guarded_class
        @guarded_methods = Array.new
        @states = Hash.new
        @method_groups = Hash.new
        @aliases = Array.new
      end

      def guard_method(method)
        @guarded_methods << method
        checked_method = checked_method_name(method)
        unchecked_method = unchecked_method_name(method)

        guarded_class.send(:define_method, checked_method) do |*args|
          if acl.allowed?(aasm_current_state, current_user, method)
            self.send(unchecked_method, *args)
          elsif StonePath::Config.acl_failure_mode == :exception
            raise "Access Violation"
          end
        end

        # Save our needed aliases until later
        @aliases << [unchecked_method, method]
        @aliases << [method, checked_method]
      end

      # fix up our saved aliases
      def fix_aliases
        @aliases.each do |src, target|
          guarded_class.send(:alias_method, src, target)
        end
      end


      def method_group(name, methods)
        @method_groups[name] = methods
      end

      def for_state(state_name)
        @states[state_name] = State.new(state_name, self) if @states[state_name].nil?
        yield @states[state_name]
      end

      def allowed?(state, user, method)
        puts "allowed called: #{state}, #{user}, #{method}"
        return true
      end

      private

      # TODO
      # these two methods are ugly - we need to dry up the repetition and make them work for ? methods.    
      def checked_method_name(method)
        method_name = method.to_s
        if method_name.include?("=")
          method_name.gsub!("=","")
          return "#{method_name}_with_check="
        else
          return "#{method_name}_with_check"
        end
      end

      def unchecked_method_name(method)
        method_name = method.to_s
        if method_name.include?("=")
          method_name.gsub!("=","")
          return "#{method_name}_without_check="
        else
          return "#{method_name}_without_check"
        end
      end
    end
  end
end