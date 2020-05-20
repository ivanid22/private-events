Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :user, only: [:new, :create, :show]
  resources :events
  get "/sign_in", to: "users#sign_in_view"
  post "/sign_in", to: "users#sign_in"

  root "events#index"
end
