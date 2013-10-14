class Admin::PlacesController < ApplicationController
  
  layout "admin"
  auto_complete_for :tag, :name 
  before_filter :find_comments, :only => [:show, :destroy]
  before_filter :authenticate

  def index 
    @changes = Change.find :all, :conditions => {:done => false }
    @places = Place.paginate :per_page => 30, :page => params[:page], :conditions => {:deleted => false}, :include => [:open_hours, :category], :order => ['active, name asc']
  end

  def show
    @place = Place.find(params[:id])
    @tag = Tag.new
    @votes = Vote.getMark (@place.id)
	prepare_map_show 
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @place }
    end
  end

  def new
    categories = Category.all
    if categories.blank?
    	flash[:notice] = 'Nie można jeszcze dodawać miejsc. Brak kategorii.'
        redirect_to(admin_categories_path)
    else
      @place = Place.new
      @place.open_hours.build
        prepare_map 
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @place }
      end
    end
  end

  def edit
    @place = Place.find(params[:id])
    prepare_map
    end

  def create
    @place = Place.new(params[:place])

      if @place.save
          if (params[:photo])  
           @photo = Photo.new(params[:photo])
	   @photo.place_id  = @place.id
           @photo.save
          end

        @history = History.create({:place_id => @place.id, :editor_id => current_editor.id, :what => "Dodano miejsce" })
        flash[:notice] = 'Miejsce zostało dodane.'
        redirect_to(admin_place_path(@place)) 
      else
        prepare_map
        render :action => "new"
      end
end

 def update
    @place = Place.find(params[:id])

      if @place.update_attributes(params[:place])
          # create tworzy nowy obiekt i od razu zapisuje
          if (params[:photo])  
            @photo = Photo.new(params[:photo])
	    @photo.place_id  = @place.id
            @photo.save
          end
        @history = History.create({:place_id => @place.id, :editor_id => current_editor.id, :what => "Zmieniono szczegóły miejsca" })
        flash[:notice] = 'Miejsce zostało zmienione.'
        redirect_to(admin_place_path(@place)) 
      else
        prepare_map
        render :action => "edit"
      end
  end

  def destroy
    @place = Place.find(params[:id])
    @place.deleted = true;
    @place.active = false;
    @history = History.create({:place_id => @place.id, :editor_id => current_editor.id, :what => "Usunięto miejsce" })
    respond_to do |format|
      flash[:notice] = 'Usunięto miejsce.'
      format.html { redirect_to(admin_places_path) }
      format.xml  { head :ok }
    end
  end

  def new_open_hours
 	id = params[:id]    
	render :partial => 'ajax_open_hours', :locals => { :id => id.to_i }
  end

  def rmphoto
    @photo = Photo.find(params[:photo_id])
    id = @photo.place_id
    @photo.destroy
    @history = History.create({:place_id => id, :editor_id => current_editor.id, :what => "Usunięto zdjęcie" })
    flash[:notice] = 'Usunięto zdjęcie.'
    redirect_to(admin_place_path(id))
  end

  protected
    def find_comments
      @comments = Comment.find(:all).map do |comment|
      [comment.contents, comment.id]
      end 
    end 

   def prepare_map_show
     @map = GMap.new("map_div")
  	@map.control_init(:large_map => true,:map_type => true)
  	if @place.longitude.nil? and @place.latitude.nil? 
  	  point = [50.061600,19.937400]  	  
  	else
  	  point = [@place.longitude,@place.latitude]
  	  #point = [50.061600,19.937400]  	  
        end
     @map.center_zoom_init(point,14)
     @gmarker = GMarker.new(point, :title => "Przeciągnij, by ustawić pozycję!", :draggable => false)
     @map.overlay_global_init(@gmarker, "gmarker")  
     @map.overlay_init(@gmarker)
     #@map.event_init(@gmarker, "dragend", "dragPlaceMarker")
  end

  def prepare_map
     @map = GMap.new("map_div")
  	@map.control_init(:large_map => true,:map_type => true)
  	if @place.longitude.nil? and @place.latitude.nil? 
  	  point = [50.061600,19.937400]  	  
  	else
  	  point = [@place.longitude,@place.latitude]
  	  #point = [50.061600,19.937400]  	  
        end
     @map.center_zoom_init(point,14)
     @gmarker = GMarker.new(point, :title => "Przeciągnij, by ustawić pozycję!", :draggable => true)
     @map.overlay_global_init(@gmarker, "gmarker")  
     @map.overlay_init(@gmarker)
     @map.event_init(@gmarker, "dragend", "dragPlaceMarker")
  end

end

