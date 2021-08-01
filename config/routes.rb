Rails.application.routes.draw do
  config = Rails.application.config.baukis2

  constraints host: config[:staff][:host] do
    namespace :staff, path: config[:staff][:path] do
      root "top#index"
      get "login" => "sessions#new", as: :login
      post "session" => "sessions#create", as: :session
      delete "session" => "sessions#destroy"
      # エラーになる(ActionController::RoutingError (No route matches [DELETE] "/session"):)
      # resource :session, only: [ :create, :destory ]
      resource :account, except: [ :new, :create, :destroy ]
    end
  end

  constraints host: config[:admin][:host] do
    namespace :admin, path: config[:admin][:path] do
      root "top#index"
      get "login" => "sessions#new", as: :login
      post "session" => "sessions#create", as: :session
      delete "session" => "sessions#destroy"
      # エラーになる(ActionController::RoutingError (No route matches [DELETE] "/session"):)
      # resource :session, only: [ :create, :destory ]
      resources :staff_members
    end
  end

  constraints host: config[:customer][:host] do
    namespace :customer, path: config[:customer][:path] do
      root "top#index"
  end
  end
end
