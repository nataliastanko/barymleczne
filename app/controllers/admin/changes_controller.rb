class Admin::ChangesController < ApplicationController

  layout "admin"
  before_filter :find_place, :only => [:destroy]
  before_filter :authenticate

  def index
    @changes = Change.paginate :page => params[:page], :per_page => 40
  end

  def done
    @change = Change.find(params[:id])
    @change.done = true;
    @change.save
    redirect_to(admin_places_path)
  end 

  def show
    @change = Change.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @change }
    end
  end

  def edit
    @change = Change.find(params[:id])
  end

  def update
    @change = Change.find(params[:id])

    respond_to do |format|
      if @change.update_attributes(params[:change])
        flash[:notice] = 'Change was successfully updated.'
        format.html { redirect_to(admin_change_path(@change)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @change.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @change = Change.find(params[:id])
    @change.destroy

    respond_to do |format|
      format.html { redirect_to(changes_url) }
      format.xml  { head :ok }
    end
  end

  protected
    def find_place
      @place = Place.find(params[:place_id])
    end 
end
