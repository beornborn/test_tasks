Rails.application.routes.draw do
  resources :user_sessions
  resources :tickets, only: [:new, :create, :show, :index, :update] do
    resources :comments, shallow: true
  end

  root 'tickets#index'

  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout
end
