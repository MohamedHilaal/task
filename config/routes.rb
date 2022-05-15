Rails.application.routes.draw do

  devise_for :users, controllers: { confirmations: 'users/confirmations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'todo#index'
  get 'todo/index', to: 'todo#index'

  get 'todo/export', to: 'todo#export'
  post 'todo/upload' => 'todo#upload'

  post '/todo/create' => 'todo#create'
  post '/todo/update' => 'todo#update'

end
