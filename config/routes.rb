require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users
  root 'topics#index'

  authenticate :users do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :topics do
    resources :posts do
      resources :comments, only: [:create]
      resources :ratings, only: [:create]
      member do
        post 'mark_post_as_read'
      end
    end
  end

  resources :comments, only: [] do
    resources :user_comment_ratings, only: [:index, :create], as: :ratings
  end

  resources :tags
end
