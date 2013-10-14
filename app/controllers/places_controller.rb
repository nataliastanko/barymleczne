class PlacesController < ApplicationController
  
  before_filter :find_category_and_tags
  before_filter :find_comments, :only => [:show]
  auto_complete_for :tag, :name 

  # show me places what I want to see (search score, too)
  def index
   # last news
    @news = New.find (:all, :conditions => {:for_guests => true}, :order => ['created_at desc'], :limit => 5 )
   # last added places
    @last_added_places = Place.find (:all, :conditions => {:active => true, :deleted => false}, :order => ['created_at desc'], :limit => 5 )  
   # last modified places
    @last_modified_places = Place.find (:all, :conditions => {:active => true, :deleted => false}, :order => ['updated_at desc'], :limit => 5 )  
   # last comments
    @comments = Comment.find (:all, :order => ['created_at desc'], :limit => 5) 
   # places
        # join z  open_hours
    @places = Place.paginate (:per_page => 30, :page => params[:page], :conditions => {:active => true, :deleted => false}, :include => [:open_hours], :order => ['name asc'])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @places }
    end
  end
  
  # gość taguje miejsce
  def tagit
    @place = Place.find(params[:id])
    if @x = Tag.find_by_name(params[:tag][:name]) 
       @place.tags << @x unless @place.tags.include?(@x) 
        # tag istnieje w bazie
        flash[:notice] = 'Otagowano miejsce'
        redirect_to(place_path(@place))
   else
    @tag = Tag.new(params[:tag])
    respond_to do |format|
      if @tag.save
        @place.tags << @tag
        flash[:notice] = 'Otagowano miejsce'
        format.html { redirect_to(place_path(@place)) }
        format.xml  { render :xml => @tag, :status => :created, :location => @tag }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
   end
  end

  # glosowanie na miejsce
  def vote
     @place = Place.find(params[:place_id])
     @vote = @place.votes.new(params[:vote])
     @vote.ip = request.remote_ip 
     if @vote.check  
       if @vote.save
          flash[:notice] = 'Dziękujemy za ocenę.'
          redirect_to(place_path(@place))
       end
     else
          flash[:notice] = 'Z tego IP oddano już głos na to miejsce w ostatnim czasie.'
          redirect_to(place_path(@place))
     end
       end

  def show
    @place = Place.find(params[:id])
    @tag = Tag.new
    @comment = Comment.new
    @vote = Vote.new
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
    	flash[:notice] = 'Nie można jeszcze dodawać miejsc'
        redirect_to(places_path)
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


  def create
    @place = Place.new(params[:place])
    @place.active = 0
     if !verify_recaptcha(:model => @place, :message => "Przepisz poprawnie kod reCaptcha")      
        flash[:notice] = 'Źle przepisałeś tektt reCaptcha.'
        prepare_map
        render :action => "new" 
     else
        if @place.save
          if !current_editor
            #dodaje gość
            who = 0
          else
            who = current_editor.id
          end
            if (params[:photo])  
              @photo = Photo.new(params[:photo])
	      @photo.place_id  = @place.id
              @photo.save
            end
          @history = History.create({:place_id => @place.id, :editor_id => who, :what => "Dodano miejsce" })
          flash[:notice] = 'Dziękujemy za propozycję.'
          redirect_to(@place) 
        else
          prepare_map
          render :action => "new" 
	end
     end

  end

  def new_open_hours
 	id = params[:id]    
	render :partial => 'ajax_open_hours', :locals => { :id => id.to_i }
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
