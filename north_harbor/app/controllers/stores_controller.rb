class StoresController < ApplicationController
  before_filter :login_required
  
  # GET /stores
  # GET /stores.xml
  def index
    @stores = Store.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stores }
    end
  end

  # GET /stores/1
  # GET /stores/1.xml
  def show
    @store = Store.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @store }
    end
  end

  # GET /stores/new
  # GET /stores/new.xml
  def new
    @store = Store.new
    @store_managers = User.find_all_by_role("store_manager")
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @store }
    end
  end

  # GET /stores/1/edit
  def edit
    @store = Store.find(params[:id])
    @store_managers = User.find_all_by_role("store_manager")
    
  end

  # POST /stores
  # POST /stores.xml
  def create
    @store = Store.new(params[:store])

    respond_to do |format|
      if @store.save
        flash[:notice] = 'Store was successfully created.'
        format.html { redirect_to(@store) }
        format.xml  { render :xml => @store, :status => :created, :location => @store }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @store.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stores/1
  # PUT /stores/1.xml
  def update
    @store = Store.find(params[:id])

    respond_to do |format|
      if @store.update_attributes(params[:store])
        flash[:notice] = 'Store was successfully updated.'
        format.html { redirect_to(@store) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @store.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.xml
  def destroy
    @store = Store.find(params[:id])
    @store.destroy

    respond_to do |format|
      format.html { redirect_to(stores_url) }
      format.xml  { head :ok }
    end
  end
end
