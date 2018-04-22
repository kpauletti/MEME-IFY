Rails.application.routes.draw do
  get 'pages/secret'
  # root "memes#index"
  resources :memes

  root :to => "memes#index"

  get 'users/new' => 'users#new', as: :new_user
  post 'users' => 'users#create'

  get '/login'     => 'sessions#new'
  post '/login'    => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

end
