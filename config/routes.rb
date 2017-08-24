Rails.application.routes.draw do
  get 'pickups/new'

  get 'pickups/show'

  get 'trips/new'

  get 'trips/show'

  get 'trips/index'

  get 'users/show'

  get 'users/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
