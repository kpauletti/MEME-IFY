Rails.application.routes.draw do
  root "memes#index"
  resources :memes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
