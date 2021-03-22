Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "static_pages#home"
    get "/logout", to: "sessions#destroy"
    resources :sessions, only: %i(new create)
    resources :users, only: %i(new create)
    resources :rooms, only: :index
    namespace :admin do
    end
  end
end
