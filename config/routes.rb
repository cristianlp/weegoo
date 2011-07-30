Neweegoo::Application.routes.draw do
  match 'auth/:provider/callback' => 'authentications#create'
  
  resources :venues do
    resources :comments, :only => [ :index, :create, :destroy ]
    resources :images, :only => [ :index, :show, :create, :destroy ] do
      resources :comments, :only => [ :index, :create, :destroy ]
    end
    
    resources :events do
      resources :comments, :only => [ :index, :create, :destroy ]
      resources :images, :only => [ :index, :show, :create, :destroy ] do
        resources :comments, :only => [ :index, :create, :destroy ]
      end
      
      member do
        get 'mark_as_visited'
        get 'mark_as_to_go'
        get 'unmark_as_visited'
        get 'unmark_as_to_go'
        
        get 'visitors'
        get 'possible_visitors'
      end
    end
    
    member do
      get 'mark_as_visited'
      get 'mark_as_to_go'
      get 'unmark_as_visited'
      get 'unmark_as_to_go'
      
      get 'visitors'
      get 'possible_visitors'
    end
    
    collection do
      get 'browse_categories'
      get 'browse_categories/:category_id/browse_sub_categories', :as => 'browse_sub_categories', :to => 'venues#browse_sub_categories'
      
      get 'map'
      get 'category_map/:category_id', :as => 'category_map', :to => 'venues#category_map'
      get 'sub_category_map/:sub_category_id', :as => 'sub_category_map', :to => 'venues#sub_category_map'
    end
  end

  devise_for :users, :controllers => { :registrations => 'registrations' }
  
  resources :users, :only => [ :index, :show ] do
    resources :authentications, :only => [ :index, :create, :destroy ]
    
    member do
      get 'friends'
      get 'mutual_friends'
      
      get 'add_as_friend/:another_user_id', :action => 'add_as_friend', :as => 'add_as_friend'
      get 'cancel_friendship_request/:another_user_id', :action => 'cancel_friendship_request', :as => 'cancel_friendship_request'
      get 'delete_friendship/:another_user_id', :action => 'delete_friendship', :as => 'delete_friendship'
      
      get 'accept_friendship/:friendship_id', :action => 'accept_friendship', :as => 'accept_friendship'
      get 'decline_friendship/:friendship_id', :action => 'decline_friendship', :as => 'decline_friendship'
      
      get 'pending_friendships'
      
      get 'find_friends_on/:provider', :action => 'find_friends', :as => 'find_friends'
      
      get 'visited_venues'
      get 'venues_to_go'
      
      get 'visited_events'
      get 'events_to_go'
    end
  end
  
  get 'update_sub_categories/:category_id', :to => 'ajax#update_sub_categories'
  
  get 'about', :to => 'main#about'
  get 'contribute', :to => 'main#contribute'
  get 'search', :to => 'main#search'
  
  root :to => 'main#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
