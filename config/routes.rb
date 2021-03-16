Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "static_pages#home"
    resources :rooms, only: :index
    namespace :admin do
    end
  end
end
