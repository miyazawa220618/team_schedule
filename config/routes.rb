Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :users, only: [:index, :show]
  resources :projects, only: [:index, :new, :create, :show]
end
