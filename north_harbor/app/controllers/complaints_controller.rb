class ComplaintsController < ApplicationController
  before_filter :login_required
  
  # GET /complaints
  # GET /complaints.xml
  def index
    @complaints = Complaint.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @complaints }
    end
  end

  # GET /complaints/1
  # GET /complaints/1.xml
  def show
    @complaint = Complaint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @complaint }
    end
  end

  # GET /complaints/new
  # GET /complaints/new.xml
  def new
    @complaint = Complaint.new
    @managers = User.find_all_by_role("customer_satisfaction_manager")
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @complaint }
    end
  end

  # GET /complaints/1/edit
  def edit
    @complaint = Complaint.find(params[:id])
    @managers = User.find_all_by_role("customer_satisfaction_manager")
  end

  # POST /complaints
  # POST /complaints.xml
  def create
    @complaint = Complaint.new(params[:complaint])

    respond_to do |format|
      if @complaint.save
        flash[:notice] = 'Complaint was successfully created.'
        format.html { redirect_to(@complaint) }
        format.xml  { render :xml => @complaint, :status => :created, :location => @complaint }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @complaint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /complaints/1
  # PUT /complaints/1.xml
  def update
    @complaint = Complaint.find(params[:id])

    respond_to do |format|
      if @complaint.update_attributes(params[:complaint])
        flash[:notice] = 'Complaint was successfully updated.'
        format.html { redirect_to(@complaint) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @complaint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /complaints/1
  # DELETE /complaints/1.xml
  def destroy
    @complaint = Complaint.find(params[:id])
    @complaint.destroy

    respond_to do |format|
      format.html { redirect_to(complaints_url) }
      format.xml  { head :ok }
    end
  end
end
