Rails.application.routes.draw do
  devise_for :users

  resources :agents
  root 'dashboard#index'
end
