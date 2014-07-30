# Any workitem or task implements a state machine, and will have events that
# can be triggered from the current state.  This controller does that.
# as long as the routes file has events as a nested resource of the workitem's controller,
# you can say:
# [post] /workitem/:id/event
class EventsController < ApplicationController
 
  before_filter :setup_parentage
 
  def index
    @events = @parentage.last.aasm_events_for_current_state
  end
  
  def new
    @event = params[:name]
    @workitem = @parentage.last
    
    if @workitem.class.aasm_events[@event.to_sym].respond_to?(:required_data)
      @required_data = @workitem.class.aasm_events[@event.to_sym].required_data
    end
  end
  
  def create
    if @parentage.last.send(params[:name] + "!", nil, params)
      # set flash, redirect to workitem.  Other logic here when we get smart.
      flash[:notice] = "Entered #{@parentage.last.aasm_state} state."
    else
      flash[:error] = @parentage.last.errors.full_messages
    end
    redirect_to polymorphic_path(@parentage)
  end
  
  private  
  
  # need to figure out how to simulate a url in testing.  mocking maybe?
  def setup_parentage
    parent_path_parts = request.path.split("/")
    parent_path_parts.shift
    @parentage = Array.new
    parent_path_parts.each_slice(2) do |k,v|
      @parentage << k.classify.constantize.find(v.to_i) unless (k == "events" || v.nil?)
    end
  end
end
