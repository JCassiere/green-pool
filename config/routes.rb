Rails.application.routes.draw do
  root to: 'home#index'

  get 'pickups/new'

  get 'pickups/show'

  get 'trips/new'

  get 'trips/show'

  get 'trips' => 'trips#index', as: "trips_index"

  get 'users/:id' => 'users#show', as: "users_show"

  get 'users/new'

  # for new users signup login logout and destroy
  get '/signup' => 'users#new'

  post '/users' => 'users#create'

  get '/login' => 'sessions#new'

  post '/login' => 'sessions#create'

  get '/logout' => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
