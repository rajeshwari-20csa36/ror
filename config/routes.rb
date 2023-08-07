# config/routes.rb

Rails.application.routes.draw do
  root 'topics#index'

  resources :topics do
    resources :posts
  end

  resources :posts do
      resources :comments, only: [:create, :destroy]
    end

  resources :posts do
    resources :ratings, only: [:create]
  end

  resources :tags
end

