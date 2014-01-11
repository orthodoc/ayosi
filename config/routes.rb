Ayosi::Application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { registrations: "registrations"}
  resources :patients
  resources :users
  resources :designations do
    member do
      post :requesting
    end
  end
  resources :hospitals
  resources :teams
end
