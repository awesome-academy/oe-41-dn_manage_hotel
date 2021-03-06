Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "static_pages#home"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "session#login"
    post "/login", to: "session#create"
    get "/logout", to: "session#destroy"
    get "/static_pages/rooms", to: "static_pages#show_rooms"
    get "static_pages/about"
    get "static_pages/gallery"
    get "/user/booked", to: "bookings#index"
    delete "/booked", to: "bookings#cancel_booked"
    resources :rooms do
        resources :bookings
    end
    namespace :admin do
       root to: "rooms#show"
       get "/rooms/new", to: "rooms#new"
       post "/rooms/new", to: "rooms#create"
    end
  end
end
