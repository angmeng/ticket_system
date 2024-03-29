TicketSystem::Application.routes.draw do

  resources :reservation_details


  resources :warrant_purchases
  namespace :api do
    resources :agents do
      collection do
      
      end
    end
    resources :staffs do
      collection do
        post :authorize
        #get :authorize
      end
    end
  end

  # get "reservations/index"
  # get "reservations/new"
  resources :reservations do
    member do
      get  :printable
    end
  end

  resources :passengers
  resources :order_item_details

  resources :orders do
    collection do
      post :search_departure
      get  :before_payment
      
      get  :payment
      post :make_payment

      get  :data_open_ticket
    end
    member do
      # get  :payment
      # post :make_payment
      get  :preview
      get  :preview_printable
      delete :void
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
  devise_for :users, :controllers => { :sessions => "users/sessions" }
  resources :users do
    member do
      get "profile"
    end
  end
  devise_for :agents, :controllers => { :sessions => "agents/sessions" }, :skip => [:sessions, :registrations] do
    get '/agents/sign_in' => 'agents/sessions#new', :as => :new_agent_session
    post '/agents/sign_in' => 'agents/sessions#create', :as => :agent_session
    delete '/agents/sign_out' => 'agents/sessions#destroy', :as => :destroy_agent_session
  end
  devise_for :staffs, :controllers => { :sessions => "staffs/sessions" }, :skip => [:sessions, :registrations] do
    get '/staffs/sign_in' => 'staffs/sessions#new', :as => :new_staff_session
    post '/staffs/sign_in' => 'staffs/sessions#create', :as => :staff_session
    delete '/staffs/sign_out' => 'staffs/sessions#destroy', :as => :destroy_staff_session
  end
  resources :branches do
    resources :agents
    resources :staffs
  end
  resources :companies

  get "home/index"
  get "home/info"
  get "dashboard/index"
  get "exception_handler/index"
  get "exception_handler/access_denied"

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
