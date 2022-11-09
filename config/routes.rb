Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :users, only: [:index, :show]
  resources :projects do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  resources :schedules do
    resources :shares, only: [:create, :edit, :update, :destroy]
  end

  get '*not_found', to: 'application#routing_error'
  post '*not_found', to: 'application#routing_error'
end