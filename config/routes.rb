Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :recipes, only: [:show, :new, :create, :edit, :update]
  resources :cuisines, only: [:show, :new, :create]
  resources :recipe_types, only: [:show, :new, :create]

end
