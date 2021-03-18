Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "static_pages#home"
    resource :rooms, only: :show
    namespace :admin do
    end
  end
end
