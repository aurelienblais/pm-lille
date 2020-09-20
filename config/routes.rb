# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :room_messages, only: [:create]
  resources :room_users, only: %i[create new]
  resources :rooms, only: %i[index show new create]
  resources :agents
  resources :teams, only: %i[index new create destroy]
  resources :ranks, only: %i[index new create destroy]
  resources :absence_types
  resources :absences, only: %i[index create]
  resources :users do
    post :reset_password, on: :member
  end

  namespace :public do
    resources :agents, only: %i[show]
  end

  root 'dashboard#index'
end
