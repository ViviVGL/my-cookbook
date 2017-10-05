Rails.application.routes.draw do
  root 'home#index'

  resources :recipes, only: [:show, :new, :create]
  resources :cuisines, only: [:show, :new, :create]
  resources :recipe_types, only: [:show, :new, :create]

end
