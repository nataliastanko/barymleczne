ActionController::Routing::Routes.draw do |map|
  map.resources :news
  
  map.connect "admin/editors/logout", :controller => "admin/editors", :action => :logout
  map.connect "places/:place_id/vote/", :controller => "places", :action => :vote
  map.connect "places/:id/tagit/", :controller => "places", :action => :tagit
  map.connect "admin/changes/:id/done/", :controller => "admin/changes", :action => :done
  map.connect "admin/editors/editme/", :controller => "admin/editors", :action => :editme
  map.connect "admin/editors/showme/", :controller => "admin/editors", :action => :showme
  map.connect "admin/editors/updateme/", :controller => "admin/editors", :action => :updateme
  map.connect "admin/places/rmphoto/:photo_id", :controller => "admin/places", :action => :rmphoto

  map.resources :changes

  map.resources :votes

  map.resources :histories

  map.resources :editors, :has_many => :histories

  map.resources :categories

  map.resources :tags, :has_many => :places

  map.resources :dishes

  map.resources :comments

  map.resources :places, :has_many => [:dishes, :tags, :histories, :votes, :editors, :changes, :photos], :collection => {:auto_complete_for_tag_name => :get }

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
     map.resources :places do |places|
       places.resources :comments
       places.resources :dishes
       places.resources :histories
       places.resources :changes
       places.resources :votes
       #places.resources :sales, :collection => { :recent => :get }
       places.resources :tags
     end

  # Sample resource route within a namespace:
     map.namespace :admin do |admin|
       # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
      admin.resources :places, :has_many => [:dishes, :tags, :histories, :votes, :editors, :changes, :photos], :collection => {:auto_complete_for_tag_name => :get }
      admin.resources :comments
      admin.resources :news
      admin.resources :categories
      admin.resources :dishes, :collection => {:auto_complete_for_dish_name => :get }
      admin.resources :tags
      admin.resources :votes
      admin.resources :histories
      admin.resources :editors, :has_many =>[:histories], :collection => {:login => :get}
      admin.resources :changes
   end

  # You cian have the root of your site routed with map.root -- just remember to delete public/index.html.

   map.connect "admin/", :controller => "admin/editors", :action => :login
   map.root :controller => :places

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
