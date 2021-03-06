Rails.application.routes.draw do
  resources :users, only: %i[new create show]
  resources :invitations, only: %i[new create index destroy show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :events
  get '/sign_in', to: 'users#sign_in_view'
  post '/sign_in', to: 'users#sign_in'
  get '/sign_out', to: 'users#sign_out'
  get 'invitations/:id/accept', to: 'invitations#accept'
  root 'events#index'
end
