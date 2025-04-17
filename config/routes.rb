Rails.application.routes.draw do
  devise_for :admin_users, controllers: {
    sessions: 'admin/sessions'
  }, path: 'admin'
  get "notifications/index"
  get "connections/create"
  get "connections/update"
  get "connections/destroy"
  get "explore/index"
  root "posts#index"
  get "home/index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
    member do
      post :like
      delete :unlike
    end
  end

  resources :users, only: [:show, :edit, :update] do
    member do
      get :profile
      get :connections
      get :chats
    end
  end

  resources :notifications, only: [:index] do
    member do
      post :mark_as_read
    end
    collection do
      post :mark_all_as_read
    end
  end

  resources :connections, only: [:index, :create, :update, :destroy] do
    member do
      post :accept
      post :reject
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

  resource :calendar, only: [:show] do
    resources :time_slots, only: [:create, :update, :destroy] do
      member do
        patch :accept_booking
        patch :reject_booking
        post :cancel_booking
      end
    end
    member do
      post :schedule
    end
  end

  namespace :admin do
    root to: 'dashboard#index'
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      member do
        post :toggle_active
      end
    end
    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :ads do
      member do
        get :performance
      end
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
