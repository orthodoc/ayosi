Ayosi::Application.routes.draw do
  resources :patients
  root to: 'patients#new'
  devise_for :users
end
