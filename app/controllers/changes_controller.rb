class ChangesController < ApplicationController

  before_filter :find_category_and_tags

    def show
    @change = Change.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @change = Change.new
    @place = Place.find(params[:place_id])
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @place = Place.find(params[:place_id])
    @change = @place.changes.new(params[:change])
    @change.done = false;
     if !verify_recaptcha(:model => @change, :message => "Przepisz poprawnie kod reCaptcha")      
        flash[:notice] = 'Źle przepisałeś tekst reCaptcha.'
        render :action => "new" 
     else 
        if @change.save
          flash[:notice] = 'Zmiana została zgłoszona.'
          redirect_to(@place)
        else
          render :action => "new"
        end
     end
  end

 end
