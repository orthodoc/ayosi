Ayosi::Application.routes.draw do
  get "memberships/destroy"
  root to: 'home#index'
  devise_for :users, controllers: { registrations: "registrations"}
  resources :patients
  resources :users
  resources :designations
  resources :hospitals do
    resources :users, only: :index
  end
  resources :teams
  resources :memberships, only: :destroy do
    member do
      post :requesting
      post :activating
      post :rejecting
      post :deactivating
      post :banning
      post :resigning
    end
  end
end
