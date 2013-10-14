class Admin::DishesController < ApplicationController

   layout "admin"
   auto_complete_for :dish, :name 
   before_filter :find_place, :only => [:new, :create]
   before_filter :authenticate

  def index
    @dishes = Dish.all :include => :place

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @dishes }
    end
  end

  # GET /dishes/1
  # GET /dishes/1.xml
  def show
    @dish = Dish.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dish }
    end
  end

  # GET /dishes/new
  # GET /dishes/new.xml
  def new
    @dish = @place.dishes.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @dish }
    end
  end

  # GET /dishes/1/edit
  def edit
    @dish = Dish.find(params[:id])
  end


  def create
    @dish = @place.dishes.new(params[:dish])
    respond_to do |format|
      if @dish.save 
        @history = History.create({:place_id => @place.id, :editor_id => current_editor.id, :what => "Dodano danie" })
        flash[:notice] = 'Danie zostało dodane.'
        format.html { redirect_to(admin_place_path(@place)) }
        format.xml  { render :xml => @dish, :status => :created, :location => @dish }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dish.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /dishes/1
  # PUT /dishes/1.xml
  def update
    @dish = Dish.find(params[:id])
    
    respond_to do |format|
      if @dish.update_attributes(params[:dish])
        @history = History.create({:place_id => @dish.place_id, :editor_id => current_editor.id, :what => "Zmieniono danie" })
        flash[:notice] = 'Zmieniono danie.'
        format.html { redirect_to(admin_place_path(@dish.place_id)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dish.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /dishes/1
  # DELETE /dishes/1.xml
  def destroy
    @dish = Dish.find(params[:id])
    id = @dish.place_id
    @dish.destroy
    respond_to do |format|
      flash[:notice] = 'Danie zostało usunięte.'
        @history = History.create({:place_id => id, :editor_id => current_editor.id, :what => "Usunięto 1 danie" })
      format.html { redirect_to(admin_place_path(id)) }
      format.xml  { head :ok }
    end
  end

  protected
    def find_place
      @place = Place.find(params[:place_id])
    end 
end
