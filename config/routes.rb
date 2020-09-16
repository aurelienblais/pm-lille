Rails.application.routes.draw do
  devise_for :users

  resources :agents
  resources :teams
  resources :ranks
  resources :absence_types
  root 'dashboard#index'
end
