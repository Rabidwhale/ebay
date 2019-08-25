Rails.application.routes.draw do
  resources :categories
  devise_for :users
  root "static_pages#index"
  resources :prods do
    resources :comments, only: :create
  end
  resources :users, only: :show
  resources :charges
end
