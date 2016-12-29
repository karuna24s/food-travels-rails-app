Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # get '/destinations/indexes', to: 'destinations#destination_indexes'

  resources :users, only: [:show] do
    resources :destinations, to: 'users#destinations'
  end

  resources :destinations do
    resources :foods
    resources :comments
  end

  root 'welcome#index'

  get '/destinations/:id/next', to: 'destinations#next_destination'

  get '/destinations/:id/previous', to: 'destinations#previous_destination'

  # get '/destinations/lastfirst' to: 'destinations#last_and_first'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
