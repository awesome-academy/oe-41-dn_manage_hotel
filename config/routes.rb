Rails.application.routes.draw do

  scope "(:locale)", locale: /en|vi/ do
    root to: "static_pages#home"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "session#login"
    post "/login", to: "session#create"
    get "/logout", to: "session#destroy"
    get "/static_pages/rooms", to: "static_pages#show_rooms"
    resources :rooms do
        resources :bookings
    end
    get "static_pages/about"
    get "static_pages/gallery"
    namespace :admin do
      root to: "dashboards#index"
      get "/rooms", to: "rooms#show"
    end
  end
end
