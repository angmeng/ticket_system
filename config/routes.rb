TicketSystem::Application.routes.draw do

  resources :orders do
    collection do
      post :search_departure
    end
    member do
      get  :payment
      post :make_payment
    end
  end

  resources :topup_credits
  resources :vessels
  resources :departures do
    collection do
      post :generate
    end
  end
  resources :schedules do
    collection do
      get :new_extra_trip
    end
  end
  resources :tickets
  resources :jetties
  resources :ticket_categories
  resources :warrants
  resources :vessells
  resources :agent_groups
  resources :routines do
    member do
      get :get_destinations
    end
  end
  resources :branches
  resources :companies

  get "home/index"
  get "home/info"
  get "dashboard/index"

  devise_for :staffs, :controllers => { :sessions => "staffs/sessions" }, :skip => [:sessions, :registrations] do
    get '/staffs/sign_in' => 'staffs/sessions#new', :as => :new_staff_session
    post '/staffs/sign_in' => 'staffs/sessions#create', :as => :staff_session
    delete '/staffs/sign_out' => 'staffs/sessions#destroy', :as => :destroy_staff_session
  end
  resources :staffs
  devise_for :agents, :controllers => { :sessions => "agents/sessions" }, :skip => [:sessions, :registrations] do
    get '/agents/sign_in' => 'agents/sessions#new', :as => :new_agent_session
    post '/agents/sign_in' => 'agents/sessions#create', :as => :agent_session
    delete '/agents/sign_out' => 'agents/sessions#destroy', :as => :destroy_agent_session
  end
  resources :agents
  resources :sub_agents

  devise_for :users, :controllers => { :sessions => "users/sessions" }
  resources :users do
    member do
      get "profile"
    end
  end

  # authenticated :user do
  #   root :to => 'dashboard#index'
  # end
  # authenticated :staff do
  #   root :to => 'dashboard#index'
  # end
  # authenticated :agent do
  #   root :to => 'dashboard#index'
  # end
  root :to => "home#index"

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
  # match ':controller(/:action(/:id))(.:format)'
end
