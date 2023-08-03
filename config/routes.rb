Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#index"

  get 'pages', to: 'pages#index'

  resource :pages, path: 'pages/*name', as: :page do
    get 'add', to: 'pages#new', on: :collection
  end
end
