Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "static_pages#home"
    resource :rooms, only: :show
    resource :users
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    namespace :admin do
    end
  end
end
