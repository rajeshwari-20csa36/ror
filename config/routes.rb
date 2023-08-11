
Rails.application.routes.draw do
  devise_for :users
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

  resources :posts do
    member do
      post :mark_as_read
    end
  end

  resources :tags
end

