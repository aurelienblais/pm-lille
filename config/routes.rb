# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :room_messages, only: %i[create destroy]
  resources :room_users, only: %i[create new]
  resources :rooms, only: %i[index show new create destroy] do
    post :purge, on: :member
  end
  resources :agents
  resources :teams, only: %i[index new create destroy]
  resources :ranks, only: %i[index new create destroy]
  resources :absence_types
  resources :absences, only: %i[index create]
  resources :recurring_absences
  resources :compensatory_rests
  resources :users do
    post :reset_password, on: :member
  end
  resources :broadcasts, only: %i[index create]

  namespace :public do
    resources :agents, only: %i[show]
  end

  authenticate :user, lambda { |u| u.superadmin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'dashboard#index'
end
