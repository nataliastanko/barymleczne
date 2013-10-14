class Admin::VotesController < ApplicationController

  layout "admin"
  before_filter :find_place, :only => [:new, :create, :index, :destroy]
  before_filter :authenticate
  def index

    @votes = @place.votes.paginate :per_page => 40, :page => params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @votes }
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to(votes_url) }
      format.xml  { head :ok }
    end
  end
  protected
    def find_place
      @place = Place.find(params[:place_id])
    end 

end
