Rails.application.routes.draw do
  resources :users
  root to: 'visitors#index'
  get '/my_collection' => 'users#my_collection', as: :my_collection
  get '/auth/:provider/callback' => 'sessions#create'
  get '/search' => 'search#index', as: :search
  get '/signin' => 'sessions#new', as: :signin
  get '/signout' => 'sessions#destroy', as: :signout
  get '/auth/failure' => 'sessions#failure'
end
