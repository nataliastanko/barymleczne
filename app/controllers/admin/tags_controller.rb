class Admin::TagsController < ApplicationController

  layout "admin"
  before_filter :find_place, :only => [:create, :destroy]
  before_filter :authenticate

  # GET /tags
  # GET /tags.xml
  def index
    @tags = Tag.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tags }
    end
  end

  # GET /tags/1
  # GET /tags/1.xml
  def show
    @tag = Tag.find(params[:id])
    @places = @tag.places.paginate :per_page => 10, :page => params[:page], :order => 'name asc'
    end

  # GET /tags/new
  # GET /tags/new.xml
  def new
    @tag = Tag.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end

 def create
  all = params[:tag][:name].split(',')
  all.each { |tag| tag.strip!
    if @x = Tag.find_by_name(tag)
       if !@place.tags.include?(@x) 
          # save
          @place.tags << @x        # tag istnieje w bazie
          @history = History.create({:place_id => @place.id, :editor_id => current_editor.id, :what => "Otagowano miejsce" })
        flash[:notice] = 'Otagowano miejsce'
       end
    else # twórz nowy
       @tag = Tag.new({"name" => tag})
         if @tag.save
           @place.tags << @tag
           @history = History.create({:place_id => @place.id, :editor_id => current_editor.id, :what => "Otagowano miejsce" })  
           flash[:notice] = 'Otagowano miejsce'
         else
           flash[:errors] = @tag
         end   
    end
  } # end each
    redirect_to (admin_place_path(@place)) 
 end

  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        flash[:notice] = 'Tag został zmieniony.'
        format.html { redirect_to(admin_tags_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @tag = Tag.find(params[:id])
    @place.tags.delete(@tag)
    @history = History.create({:place_id => @place.id, :editor_id => current_editor.id, :what => "Usunięto tag dla miejsca" })
    respond_to do |format|
      format.html { redirect_to(admin_place_path(@place)) }
      format.xml  { head :ok }
    end
  end

  protected
    def find_place
      @place = Place.find(params[:place_id])
    end 

end
