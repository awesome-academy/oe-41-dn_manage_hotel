Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "static_pages#home"
    get "/logout", to: "sessions#destroy"
    resources :sessions, only: %i(new create)
    resources :users, only: %i(new create)
    resources :users do
      resources :bookings, only: :index
    end
    resources :rooms, only: :index
    resources :rooms do
      resources :bookings
    end
    namespace :admin do
    end
  end
end
