Rails.application.routes.draw do
  resources :user_sessions
  resources :tickets, only: [:new, :create]

  root 'tickets#new'

  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout
end
