module StonePath
  module ACL
    class State
      attr_reader :name
      attr_reader :roles
      attr_reader :parent_acl

      def initialize(name, parent_acl)
        @name = name
        @parent_acl = parent_acl
        @roles = Hash.new
      end

      def access_for_role(role_name)
        @roles[role_name] = Role.new(role_name, self) if @roles[role_name].nil?
        yield @roles[role_name]
      end
    end
  end
end