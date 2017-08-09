Rails.application.routes.draw do
  root "static_pages#show", page: "home"

  get "static_pages/:page", to: "static_pages#show", as: "static_page"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :account_activations, only: :edit
  resources :password_resets, except: %i(index show destroy)
end
