class CategoriesController < ApplicationController

  before_filter :find_category_and_tags

 # wyniki wyszukiwania po kategorii
 def show
# category
    @category = Category.find(params[:id])
# last news
    @news = New.find (:all, :conditions => {:for_guests => true}, :order => ['created_at desc'], :limit => 5 )
# places from category
    @places = @category.places.paginate(:per_page => 10, :page => params[:page],:conditions => {:active => true, :deleted => false}, :order => 'name asc')
# last comments
    @comments = Comment.find (:all, :order => ['created_at desc'], :limit => 5) 
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end

end
