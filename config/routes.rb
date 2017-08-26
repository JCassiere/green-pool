Rails.application.routes.draw do

  root 'home#index'

  get 'pickups/new'

  get 'pickups/show'

  get 'trips/new'

  get 'trips/show'

  get 'trips/index'

  get 'users/:id' => 'user#show'

  get 'users/new'

  # for new users signup login logout and destroy
  get '/signup' => 'users#new'

  post '/users' => 'users#create'

  get '/login' => 'sessions#new'

  post '/login' => 'sessions#create'

  get '/logout' => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
