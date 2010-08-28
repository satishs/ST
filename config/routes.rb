ActionController::Routing::Routes.draw do |map|
  map.resources :giftstates
  map.resources :sponsers
  map.resources :line_items
  map.resources :vendors
  map.resources :posts, :has_many => :vendors, :collection => {:sponser => :post, :add_to_cart => :get }
  map.resources :organizations
  map.resources :users

  
  map.root :controller => 'posts', :actions => 'index'
  map.resources :answers
  map.resources :questions
  map.resources :tags
  map.resources :users 
  map.resources :user_sessions
  map.resources :password_resets
  
  #map.sponser "sponser_post", :controller => :posts, :action => "sponser"
  map.dashboard "dashboard", :controller => :posts, :action => "dashboard"
  map.search "search", :controller => :posts, :action => "search"
  map.login "login", :controller => :user_sessions, :action => "new"
  map.logout "logout", :controller => :user_sessions, :action => "destroy"
  #map.sponsor_gift "sponsor", :controller => :sponsor, :action => "sponsor_gift"
  map.sponsored "sponsored", :controller => :posts, :action => "sponsored"
  map.capture_orderno "capture_orderno", :controller => :posts, :action => "capture_orderno"
  map.empty_cart "empty_cart", :controller => :posts, :action => "empty_cart", :method => :get
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action
  # 
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
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
