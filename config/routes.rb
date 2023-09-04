Rails.application.routes.draw do
  resources :tickets do
    resources :comments, only: [:create]
  end
  resources :users, only: [:new, :create]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  root 'users#new'
end
