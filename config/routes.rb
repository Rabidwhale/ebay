Rails.application.routes.draw do
  root "prods#index"
  resources :prods, only: [:new, :create]
end
