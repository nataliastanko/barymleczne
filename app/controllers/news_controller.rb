class NewsController < ApplicationController

  before_filter :find_category_and_tags

  def index
    @news = New.paginate (:per_page => 10, :page => params[:page], :conditions => {:for_guests => true}, :order => ['created_at desc'])
 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @news }
    end
  end

  # GET /news/1
  # GET /news/1.xml
  def show
    @new = New.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @new }
    end
  end

  # GET /news/new
  # GET /news/new.xml
  def new
    @new = New.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @new }
    end
  end

  # GET /news/1/edit
  def edit
    @new = New.find(params[:id])
  end

  # POST /news
  # POST /news.xml
  def create
    @new = New.new(params[:new])

    respond_to do |format|
      if @new.save
        flash[:notice] = 'New was successfully created.'
        format.html { redirect_to(@new) }
        format.xml  { render :xml => @new, :status => :created, :location => @new }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @new.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /news/1
  # PUT /news/1.xml
  def update
    @new = New.find(params[:id])

    respond_to do |format|
      if @new.update_attributes(params[:new])
        flash[:notice] = 'New was successfully updated.'
        format.html { redirect_to(@new) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @new.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.xml
  def destroy
    @new = New.find(params[:id])
    @new.destroy

    respond_to do |format|
      format.html { redirect_to(news_url) }
      format.xml  { head :ok }
    end
  end
end
