module Rails
  module Generator
    module Commands      
      
         Create.class_eval {
            def route_stonepath_workitems(resource)
              sentinel = 'ActionController::Routing::Routes.draw do |map|'
              logger.route "map.stonepath_workitems #{resource}"
              unless options[:pretend]
                gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |match|
"#{match}

  map.resources :#{resource} do |o|
    o.resource :event, {:only => \"create\", :controller => \"#{resource.singularize}_events\"}
  end
"
                end
              end
            end
          }
          
          
      Destroy.class_eval {
        def route_stonepath_workitems(*resources)
          resource_list = resources.map { |r| r.to_sym.inspect }.join(', ')
          look_for = "\n  map.stonepath_workitems #{resource_list}\n"
          logger.route "map.stonepath_workitems #{resource_list}"
          gsub_file 'config/routes.rb', /(#{look_for})/mi, ''
        end
      }
      
      
      List.class_eval {
        def route_stonepath_workitems(*resources)
          resource_list = resources.map { |r| r.to_sym.inspect }.join(', ')
          logger.route "map.stonepath_workitems #{resource_list}"
        end
      }
      
    end
  end
end