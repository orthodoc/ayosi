Ayosi::Application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { registrations: "registrations"}
  resources :patients
  resources :users
  resources :designations
  resources :hospitals
end
