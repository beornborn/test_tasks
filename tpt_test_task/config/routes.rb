Rails.application.routes.draw do
  namespace :v1 do
    post 'signup', to: 'users#create'
    post 'login', to: 'sessions#create'

    resources :users do
      get :me, on: :collection
    end
    resources :activities
  end
end
