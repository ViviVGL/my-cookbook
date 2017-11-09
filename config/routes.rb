Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :recipes, only: %i[show new create edit update] do
    post 'email_to_friend', on: :member
    post 'favorite', on: :member
  end
  resources :cuisines, only: %i[show new create]
  resources :recipe_types, only: %i[show new create]
  get '/favorites', to: 'favorites#index', as: 'user_favorites'
end
