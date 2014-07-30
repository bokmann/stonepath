class FollowUpActionsController < ApplicationController
  before_filter :login_required, :setup_complaint
  
  def index
    @follow_up_actions = Complaint.find(params[:complaint_id]).follow_up_actions

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @follow_up_actionss }
    end
  end

  def show    
    @follow_up_action = Complaint.find(params[:complaint_id]).follow_up_actions.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @follow_up_actions }
    end
  end

  def new
    @follow_up_action = FollowUpAction.new
    workbench = @complaint.store.manager
    @follow_up_action.workbench = workbench
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @follow_up_actions }
    end
  end

  def edit
    @follow_up_action = Complaint.find(params[:complaint_id]).follow_up_actions.find(params[:id])
    
  end

  def create    
    @follow_up_action = @complaint.follow_up_actions.new(params[:follow_up_action])
    @follow_up_action.workbench = User.find params[:follow_up_action][:workbench_id]
    respond_to do |format|
      if @follow_up_action.save
        flash[:notice] = 'FollowUpAction was successfully created.'
        format.html { redirect_to([@complaint, @follow_up_actions]) }
        format.xml  { render :xml => @follow_up_actions, :status => :created, :location => @follow_up_actions }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @follow_up_actions.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @follow_up_action = Complaint.find(params[:complaint_id]).follow_up_actions.find(params[:id])
    @follow_up_action.workbench = User.find params[:follow_up_action][:workbench_id]

    respond_to do |format|
      if @follow_up_action.update_attributes(params[:follow_up_action])
        flash[:notice] = 'FollowUpAction was successfully updated.'
        format.html { redirect_to(@follow_up_actions) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @follow_up_action.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @follow_up_action = Complaint.find(params[:complaint_id]).follow_up_actions.find(params[:id])
    @follow_up_action.destroy

    respond_to do |format|
      format.html { redirect_to(complaint_follow_up_actions_url(@complaint)) }
      format.xml  { head :ok }
    end
  end
  
  def setup_complaint
    @complaint = Complaint.find(params[:complaint_id])
  end
end
