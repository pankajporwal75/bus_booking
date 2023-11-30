Rails.application.routes.draw do

  devise_scope :user do
    patch "/verification/", to: "users/sessions#otp_verification", as: :verify_login
    patch "/verification/resend_otp", to: "users/sessions#resend_otp", as: :resend_otp
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations', 
    sessions: "users/sessions",
  }
  root to: "buses#index"

  resources :bus_owners

  resources :users do
    resources :reservations
  end
  
  resources :buses do
    resources :reservations
  end
  get 'admin/dashboard', to: "admins#index", as: :admin_dashboard
  get 'admin/users', to: "users#index", as: :all_users
  get 'admin/bus_owners', to: "bus_owners#index", as: :all_bus_owners
  get 'admin/buses', to: "buses#index", as: :all_buses
  patch 'change_status/:bus_owner/bus/:id' ,to: "admins#change_status" ,as: :change_status
  get '/reservations/search', to: "reservations#search", as: :search_reservations
  get '/search', to: "buses#search", as: :search_buses

  # Defines the root path route ("/")
  # root "articles#index"
end
