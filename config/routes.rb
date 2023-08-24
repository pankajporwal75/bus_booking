Rails.application.routes.draw do
  devise_for :users
  root to: "buses#index"
  resources :bus_owners
  resources :users do
    resources :reservations
  end
  resources :buses do
    resources :reservations
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
