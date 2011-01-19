class LinksController < ApplicationController
  before_filter :authenticate_user!, :except => :hit
  before_filter :get_group, :except => [:hit,:new]
  before_filter :get_link, :except => [:hit,:index,:new,:create]
  
  def hit 
    if user_signed_in? and current_user.links.exists?(params[:id])
      Link.increment_counter(:hit_count, params[:id].to_i)
    end
    head :ok
  end
  
  # GET /links
  # GET /links.xml
  def index
    @links = @group.links.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @links }
    end
  end

  # GET /links/1
  # GET /links/1.xml
  def show
    @link = @group.links.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @link }
    end
  end

  # GET /links/new
  # GET /links/new.xml
  def new
    @link = Link.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @link }
    end
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.xml
  def create
    @link = Link.new(params[:link])
    @link.user=current_user
    @link.group=@group
    
    respond_to do |format|
      if @link.save
        format.html { redirect_to([@group,@link], :notice => 'Link was successfully created.') }
        format.xml  { render :xml => @link, :status => :created, :location => @link }
        format.js  { render :text=>"$(\"#group-#{@link.group_id}>ul\").append(\'<li><a href=\"#{@link.url}\" target=\"_blank\">#{@link.name}</a></li>\');" }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /links/1
  # PUT /links/1.xml
  def update
    @link.user=current_user
    @link.group=@group
    
    respond_to do |format|
      if @link.update_attributes(params[:link])
        format.html { redirect_to([@group,@link], :notice => 'Link was successfully updated.') }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.xml
  def destroy
    @link.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
  
  private
  
    def get_group
      @group = current_user.groups.find(params[:group_id]) if params[:group_id]
    end
    
    def get_link
      @link = @group.links.find(params[:id]) if @group
      @link ||= current_user.links.find(params[:id])
    end  
end
