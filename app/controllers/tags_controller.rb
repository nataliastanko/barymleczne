class TagsController < ApplicationController

  before_filter :find_category_and_tags

  def show
    @tag = Tag.find(params[:id])
# places from tags
    @places = @tag.places.paginate(:per_page => 10, :page => params[:page], :conditions => {:active => true, :deleted => false}, :order => 'name asc');
# category
    @category = Category.find(params[:id])
# last news
    @news = New.find (:all, :conditions => {:for_guests => true}, :order => ['created_at desc'], :limit => 5 )
# last comments
    @comments = Comment.find (:all, :order => ['created_at desc'], :limit => 5) 
  end

 def create

  @place = Place.find(params[:place_id])
     if !verify_recaptcha(:model => @tag, :message => "Przepisz poprawny kod reCaptcha")      
        flash[:notice] = 'Źle przepisałeś text reCaptcha.'
        redirect_to @place
        flash[:errors] = @tag
     else
         if !current_editor
           #dodaje gość
           who = 0
         else
           who = current_editor.id
         end
 
         all = params[:tag][:name].split(',')
         all.each { |tag| tag.strip!
           if @x = Tag.find_by_name(tag)
              if !@place.tags.include?(@x) 
                # save
                @place.tags << @x        # tag istnieje w bazie
                @history = History.create({:place_id => @place.id, :editor_id => who, :what => "Otagowano miejsce." })
                flash[:notice] = 'Otagowano miejsce'
              end
           else # twórz nowy
                @tag = Tag.new({"name" => tag})
               if @tag.save
                   @place.tags << @tag
                   @history = History.create({:place_id => @place.id, :editor_id => who, :what => "Otagowano miejsce" })
                   flash[:notice] = 'Otagowano miejsce'
                else
                   flash[:errors] = @tag
                end   
           end
         } # end each
    redirect_to (place_path(@place)) 
   end
end

end
