Rails.application.routes.draw do
  resources :users, except: :show
  root to: 'visitors#index'

  # collection
  get '/my_collection' => 'collection#my_collection', as: :my_collection
  get '/collection/:id' => 'collection#collection', as: :collection
  post '/collection/add_to_collection', as: :add_to_collection
  post '/collection/remove_from_collection', as: :remove_from_collection
  
  # search
  get '/search' => 'search#index', as: :search
  
  # auth
  get '/signin' => 'sessions#new', as: :signin
  get '/signout' => 'sessions#destroy', as: :signout
  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
end
