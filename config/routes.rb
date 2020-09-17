Rails.application.routes.draw do
  devise_for :users

  resources :agents
  resources :teams
  resources :ranks
  resources :absence_types
  resources :absences, only: [:create]
  root 'dashboard#index'
end
