class DishesController < ApplicationController

  def show
    @dish = Dish.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dish }
    end
  end
end
