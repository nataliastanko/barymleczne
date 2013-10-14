class Admin::CommentsController < ApplicationController


 layout "admin"
  before_filter :authenticate
  before_filter :find_comment
  
  def index
    @comments = Comment.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end


  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  def update
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        @history = History.create({:place_id => @comment.place.id, :editor_id => current_editor.id, :what => "Edytowano komentarz o id #{@comment.id}" })
        flash[:notice] = 'Komentarz został zmieniony.'
        format.html { redirect_to(admin_comment_path(@comment)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    id = @comment.place_id
    @comment.destroy
        @history = History.create({:place_id => id, :editor_id => current_editor.id, :what => "Usunięto komentarz" })

     respond_to do |format|
      flash[:notice] = 'Komentarz został usunięty.'
      format.html { redirect_to(admin_place_path(id)) }
      format.xml  { head :ok }
    end
  end

  protected
    def find_comment
	@comment = Comment.find(params[:id])
      end

end
