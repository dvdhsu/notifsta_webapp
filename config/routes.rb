NotifstaWebapp::Application.routes.draw do
  root to: 'pages#home'

  post 'v1/events/:id', to: 'api_events#update', as: 'hacky_event_update'
  scope 'v1' do
    scope 'auth' do
      get 'login' => 'api_authentication#login'
      get 'logout' => 'api_authentication#logout'
      get 'facebook' => 'api_authentication#facebook_register_or_login'
      get 'login_with_token' => 'api_authentication#login_with_token'
      get 'register' => 'api_authentication#register'
      get 'get_authentication_token' => 'api_authentication#get_authentication_token'
    end
    resources :users, only: [:show], controller: :api_users
    resources :subscriptions, only: [:show, :create, :destroy], controller: :api_subscriptions
    resources :events, only: [:index, :show, :create, :update], controller: :api_events do
      resources :channels, only: [:index], controller: :api_channels
      resources :subscriptions, only: :index, controller: :api_subscriptions
      resources :subevents, only: [:index, :create], controller: :api_subevents
    end
    resources :subevents, only: [:destroy], controller: :api_subevents
    resources :channels, only: [:show], controller: :api_channels do
      resources :notifications, only: [:index, :create], controller: :api_notifications
    end
    resources :notifications, only: [:show], controller: :api_notifications do
      resources :responses, only: [:index, :show, :create], controller: :api_responses
    end
    resources :responses, only: [:show], controller: :api_responses
  end

  devise_for :users

  namespace :admin do
    root "base#index"
    resources :users
  end

end
