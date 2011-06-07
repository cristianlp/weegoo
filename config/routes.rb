Weegoo::Application.routes.draw do
  match "/auth/:provider/callback" => "authentications#create"
  
  get "update_sub_categories/:category_id", :to => "ajax#update_sub_categories"
  
  resources :points_of_interest do
    member do
      get "been"
      get "not_been"
      get "want_to_go"
      get "dont_want_to_go"

      get "been_users"
      get "want_to_go_users"
      get "been_friends"
      get "want_to_go_friends"
    end
    
    resources :media_files do
      resources :media_file_comments
    end
    
    resources :point_of_interest_comments
  end
  
  resources :events, :except => [ :index ]
  
  resources :venues, :except => [ :index ]
  
  root :to => "main#index"
  
  get "about", :to => "main#about"
  get "contribute", :to => "main#contribute"
  
  devise_for :users, :controllers => { :registrations => "registrations" }
  
  get "users", :to => "users#index"
  get "users/:username", :to => "users#show", :as => "user"
  
  get "users/:username/add_as_friend/:another_user_username", :to => "users#add_as_friend", :as => "add_as_friend"
  get "users/:username/cancel_friendship_request/:another_user_username", :to => "users#cancel_friendship_request", :as => "cancel_friendship_request"
  get "users/:username/accept_friendship/:friendship_id", :to => "users#accept_friendship", :as => "accept_friendship"
  get "users/:username/decline_friendship/:friendship_id", :to => "users#decline_friendship", :as => "decline_friendship"
  get "users/:username/delete_friendship/:another_user_username", :to => "users#delete_friendship", :as => "delete_friendship"
  
  get "users/:username/friendship_requests", :to => "users#friendship_requests", :as => "friendship_requests"
  get "users/:username/friends", :to => "users#friends", :as => "friends"
  get "users/:username/mutual_friends", :to => "users#mutual_friends", :as => "mutual_friends"
  get "users/:username/other_applications_friends/:provider", :to => "users#other_applications_friends", :as => "other_applications_friends"
  
  get "users/:username/visited_places", :to => "users#visited_places", :as => "visited_places"
  get "users/:username/places_to_go", :to => "users#places_to_go", :as => "places_to_go"
  
  #resources :authentications, :only => [ :index, :create, :destroy ]
  get "users/:username/authentications", :to => "authentications#index", :as => "user_authentications"
  post "users/:username/authentications", :to => "authentications#create", :as => "user_authentication"
  delete "users/:username/authentications/:id", :to => "authentications#destroy", :as => "delete_user_authentication"
  
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
