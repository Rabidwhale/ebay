Rails.application.routes.draw do
  devise_for :users
  root "prods#index"
  resources :prods, only: [:new, :create, :show]
end
