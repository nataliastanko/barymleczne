# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def find_category_and_tags
    @categories = Category.find :all   
    @tags = Tag.find :all    
  end

 protected
   #return current editor 
   def current_editor
     return unless session[:editor_id]
      @current_editor ||= Editor.find_by_id(session[:editor_id])
   end

   helper_method :current_editor
   
  def authenticate
     logged_in? ? true : acces_denied
   end

  def logged_in?
    current_editor.is_a? Editor
  end

  helper_method :logged_in?

  def acces_denied
    flash[:notice] = "Zaloguj się."
    redirect_to :controller => "admin/editors", :action => "login" and return false
  end
end
