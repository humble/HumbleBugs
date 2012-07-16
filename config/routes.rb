HumbleBugs::Application.routes.draw do
  resources :bundles do
    resources :games
  end

  resources :games do
    resources :issues
    resources :releases
    resources :ports
  end

  resources :issues, :only => [:new, :create] do
    resources :comments, :except => [:index]
  end

  resources :users

  resources :predefined_tags do
    collection do
      get ':context', :action => 'complete', :as => :complete, :constraints => {
          context: /(new[a-z]+|(?!new)[a-z]+)/
      }
    end
  end

  get '/feedback' => 'feedback#new', :as => :feedback
  post '/feedback' => 'feedback#create', :as => :feedback

  get '/login' => 'sessions#new', :as => :login
  if Rails.env.test? || Rails.env.development?
    post '/secret_login' => 'sessions#secret_login', :as => :secret_login
  end
  post '/login' => 'sessions#create', :as => :login
  get '/logout' => 'sessions#destroy', :as => :logout

  get '/forgot_password' => 'password_reset#new', :as => :forgot_password
  post '/forgot_password' => 'password_reset#create', :as => :forgot_password
  get '/forgot_password/:id' => 'password_reset#edit', :as => :password_reset
  put '/forgot_password/:id' => 'password_reset#update', :as => :password_reset

  get '/confirm_account/:id' => 'confirm_account#confirm', :as => :confirm_account

  get 'signup' => 'users#new', :as => :signup

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
  root :to => 'dashboard#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
