Rails.application.routes.draw do

  root 'home#index'

  resources :trips do
    resources :pickups, shallow: true
  end

  get 'pickups/:id/update' => 'pickups#update_status', as: "pickups_update"

  # get 'pickups/new'

  # get 'pickups/show'

  # get '/trips/new' => 'trips#new'

  # post '/trips' => 'trips#create'


  # get 'trips/:id' => 'trips#show', as: "trips_show"


  #get 'users/:id' => 'users#show', as: 'user'

  # get 'trips' => 'trips#index', as: "trips_index"

  post 'users/transfer/:id' => 'users#transfer', as: "transfer_credit" 

  get 'users/show'

  get 'users/new'

  # for new users signup login logout and destroy
  get '/signup' => 'users#new'

  post '/users' => 'users#create'

  get '/login' => 'sessions#new'

  post '/login' => 'sessions#create'

  get '/logout' => 'sessions#destroy'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
