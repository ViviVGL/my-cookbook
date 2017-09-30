Rails.application.routes.draw do
  root 'home#index'

  resources :recipes, only: [:show, :new, :create]

end
