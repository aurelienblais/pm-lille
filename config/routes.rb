Rails.application.routes.draw do
  resources :room_messages, only: [:create]
  resources :room_users, only: [:create, :new]
  resources :rooms
  devise_for :users

  resources :agents
  resources :teams
  resources :ranks
  resources :absence_types
  resources :absences, only: [:create]
  root 'dashboard#index'
end
