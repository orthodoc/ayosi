Ayosi::Application.routes.draw do
  resources :patients, only: [:new]
  root to: 'patients#new'
  devise_for :users
end
