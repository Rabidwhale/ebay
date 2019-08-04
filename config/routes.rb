Rails.application.routes.draw do
  resources :categories
  devise_for :users
  root "static_pages#index"
  resources :prods
  resources :users, only: :show
end
