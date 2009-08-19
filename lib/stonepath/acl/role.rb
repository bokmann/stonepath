module StonePath
  module ACL
    class Role
      attr_reader :name
      attr_reader :parent_state
      attr_reader :allowed_methods
      attr_reader :denied_methods
      attr_reader :checked_methods

      def initialize(name, parent_state)
        @name = name
        @parent_state = parent_state
        @allowed_methods = Array.new
        @denied_methods = Array.new
        @checked_methods = Hash.new
      end

      def parent_acl
        @parent_state.parent_acl
      end

      def deny_method(method)
        @denied_methods << method
      end

      def allow_method(method)
        @allowed_methods << method
      end

      def check_method_access(method, &check)
        @checked_methods[method] = check
      end

      def deny_method_group(group)
        parent_acl.method_groups[group].each do |method|
          deny_method(method)
        end
      end

      def allow_method_group(method_group)
        parent_acl.method_groups[group].each do |method|
          allow_method(method)
        end
      end

      def check_method_group_access(method_group, &check)
        parent_acl.method_groups[group].each do |method|
          check_method_access(check)
        end
      end
    end
  end
end