Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :recipes, only: [:show, :new, :create, :edit, :update] do
    post 'email_to_friend', on: :member
    get 'favorite', on: :member
  end
  resources :cuisines, only: [:show, :new, :create]
  resources :recipe_types, only: [:show, :new, :create]
  get '/users/:id/favorites', to: "favorites#index", as: 'user_favorites'
end
