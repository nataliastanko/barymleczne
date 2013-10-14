class CommentsController < ApplicationController

   def create
    #dodane
    #id komentarza, .place to relacja belongs_to
    @place = Place.find(params[:place_id])
    @comment = @place.comments.new(params[:comment])

#    if !verify_recaptcha(:model => @comment, :message => "Przepisz poprawnie kod reCaptcha")      
#      flash[:notice] = 'Źle przepisałeś tekst reCaptcha.'
#      flash[:com_errors] = @comment
#      format.html { redirect_to(place_path(@place)) }
#      format.xml  { render :xml => @comment.errors, :status => :unprocessable_entit}
#    else
        respond_to do |format|
         if @comment.save
          flash[:notice] = 'Komentarz został dodany.'
          format.html { redirect_to(@place) }
          format.xml  { render :xml => @comment, :status => :created, :location => @comment }
         else
          flash[:com_errors] = @comment
          format.html { redirect_to(place_path(@place)) }
          format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
         end
        end
 #  end
   end
 end
