Rails.application.routes.draw do
  devise_for :users
  root to: "buses#index"
  resources :users do
    resources :bookings
  end
  resources :buses do
    resources :bookings
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
