Rails.application.routes.draw do
  resources :users
  root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  # collection
  get '/my_collection' => 'collection#show', as: :my_collection
  post '/collection/remove_from_collection', as: :remove_from_collection
  get '/search' => 'search#index', as: :search
  get '/signin' => 'sessions#new', as: :signin
  get '/signout' => 'sessions#destroy', as: :signout
  get '/auth/failure' => 'sessions#failure'
end
