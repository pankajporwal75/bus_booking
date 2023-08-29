Rails.application.routes.draw do
  devise_for :users
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

  get 'change_status/:bus_owner/bus/:id' ,to: "admins#change_status" ,as: :change_status
  # get 'disapprove/:bus_owner/bus/:id' ,to: "admins#disapprove" ,as: :disapprove 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
