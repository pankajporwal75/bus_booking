Rails.application.routes.draw do

  devise_scope :user do
    get "/otp_verification", to: "users/confirmations#otp_verification", as: :otp_verification
    post "/verify_otp", to: "users/confirmstions#verify_otp", as: :verify_otp
    patch "/verification", to: "users/sessions#otp_verification", as: :verify_login
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations', 
    sessions: "users/sessions",
    passwords: "users/passwords",
    confirmations: "users/confirmations"
  }
  root to: "buses#index"
  resources :bus_owners do
    resources :buses
  end
  resources :users do
    resources :reservations
  end
  resources :buses do
    resources :reservations
  end
  get 'admin/bus_owners', to: "bus_owners#index", as: :all_bus_owners
  patch 'change_status/:bus_owner/bus/:id' ,to: "admins#change_status" ,as: :change_status
  get 'search', to: "buses#search", as: :search_buses
  # get 'disapprove/:bus_owner/bus/:id' ,to: "admins#disapprove" ,as: :disapprove 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
