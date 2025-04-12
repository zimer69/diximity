Rails.application.routes.draw do
  devise_for :admin_users
  get "notifications/index"
  get "connections/create"
  get "connections/update"
  get "connections/destroy"
  get "explore/index"
  root "posts#index"
  get "home/index"
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resources :posts, only: [:index, :show]
  resources :users, only: [:index, :show, :update]
  resources :notifications, only: [:index, :update, :destroy] do
    member do
      patch :mark_as_read
    end
  end
  resources :connections, only: %i[index create destroy] do
    member do
      patch :accept
      delete :reject
    end
  end
  resources :chats, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end

  resources :ads do
    member do
      post 'track_click'
    end
  end

  namespace :admin do
    root 'dashboard#index'
    resources :users
    resources :posts
    resources :ads do
      member do
        get 'performance'
      end
    end
  end
end
