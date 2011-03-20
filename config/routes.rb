Weegoo::Application.routes.draw do
  get "update_sub_categories/:category_id", :to => "ajax#update_sub_categories"
  
  get "points_of_interest", :to => "points_of_interest#index"

  resources :events

  resources :venues

  root :to => "main#index"

  devise_for :users
  
  get "users", :to => "users#index"
  get "users/:id", :to => "users#show", :as => "user"
  
  get "users/:id/add_as_friend/:another_user_id", :to => "users#add_as_friend", :as => "add_as_friend"
  get "users/:id/accept_friendship/:friendship_id", :to => "users#accept_friendship", :as => "accept_friendship"
  get "users/:id/decline_friendship/:friendship_id", :to => "users#decline_friendship", :as => "decline_friendship"
  
  get "users/:id/friendship_requests", :to => "users#friendship_requests", :as => "friendship_requests"
  get "users/:id/friends", :to => "users#friends", :as => "friends"

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
