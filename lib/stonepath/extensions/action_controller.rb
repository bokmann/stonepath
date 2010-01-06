if Object.const_defined?(:ActionController)

  module ActionController
    module Resources
    
      def define_events_controller(object_sym)
        class_name = object_sym.to_s.classify
        controller_name = class_name + "EventsController"

        # This is some amazing bit of meta that will probably go away when we have
        # a work_item generator.  In short, at runtime, this defines the controller
        # that handles events for something declared in the routes file as a
        # stonepath_workitem
        Object.const_set(controller_name, ApplicationController.clone).class_eval do
          id_name = (class_name.downcase + "_id").to_sym
          #still need generic http error handling    
          define_method("create") do
            if request.post?
              @object = get_class(class_name).find(params[id_name])
              event = params[:id]
              if get_class(class_name).aasm_events.keys.include?(event.to_sym)
                respond_to do |format|
                  if @object.send(event + "!")
                    flash[:notice] = "Event '#{event}' was successfully performed."
                    format.html { redirect_to(@object) }
                    format.xml  { render :xml => @object }
                  else
                    flash[:notice] = "Event '#{event}' was NOT successfully performed."
                    format.html { redirect_to(@object) }
                    format.xml  { render :xml => @object.errors, :status => :unprocessable_entity }
                  end
                end
              end
            end
          end
        end

      end
      
      def stonepath_workitems(resources_symbol, params={})
        singular_resource_name = resources_symbol.to_s.singularize
        self.resources resources_symbol, params do |o|
          o.resource :event, {:only => "create", :controller => "#{singular_resource_name}_events"}
        end
        define_events_controller(resources_symbol)
      end
    end
  end

end