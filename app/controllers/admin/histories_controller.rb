class Admin::HistoriesController < ApplicationController
  layout "admin"
  before_filter :authenticate

  def index

   if !params[:editor_id].nil?
     # dla jednego edytora
     @editor = Editor.find params[:editor_id]
     @histories = @editor.histories.paginate (:per_page => 40, :page => params[:page], :order => 'created_at desc')

   elsif !params[:place_id].nil?

     # dla jednego miejsce
     @place = Place.find params[:place_id]
     @histone = @place.histories.paginate (:per_page => 40, :page => params[:page], :order => 'created_at desc')

   else

     # cała historia
     @histall = History.paginate (:per_page => 40, :page => params[:page], :include => [:place,:editor], :order => 'created_at desc')

   end

 end
 
  # historia zmian jednego miejsca 
  def oneplace 
  end
end 
