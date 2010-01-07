if Object.const_defined?(:ActionController)

  module ActionController
    module Resources
      
      def stonepath_workitems(resources_symbol, params={})
        singular_resource_name = resources_symbol.to_s.singularize
        self.resources resources_symbol, params do |o|
          o.resource :event, {:only => "create", :controller => "#{singular_resource_name}_events"}
        end
      end
    end
  end

end