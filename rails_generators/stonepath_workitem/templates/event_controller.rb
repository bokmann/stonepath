# this is now your file to do with as you see fit.  Before you modify it though, make sure you
# understand how the nested restful routes are defined in the routes.rb file!

class <%= class_name %>EventsController < ApplicationController

  def create
    if request.post?
      @object = <%= class_name %>.find(params[:<%= object_id_name %>])
      event = params[:id]
      if <%= class_name %>.aasm_events.keys.include?(event.to_sym)
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