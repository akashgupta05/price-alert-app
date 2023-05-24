Rails.application.routes.draw do
  post 'users/create', to: 'users#create'
  post 'sessions/create', to: 'sessions#create'
  post 'alerts/create', to: 'alerts#create'
  put 'alerts/delete/:id', to: 'alerts#delete'
  get 'alerts', to: 'alerts#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
