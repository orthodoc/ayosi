Ayosi::Application.routes.draw do
  get "memberships/destroy"
  root to: 'home#index'
  devise_for :users, controllers: { registrations: "registrations"}
  mount API::Base, at: "/"
  mount GrapeSwaggerRails::Engine, at: "/documentation"
  resources :patients, only: [:index, :new, :create, :show]
  resources :users
  resources :data
  resources :designations do
    collection do
      put :make_default
    end
  end
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
