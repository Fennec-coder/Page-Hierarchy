Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#index'

  get '', to: 'pages#index', as: :pages
  post '',  to: 'pages#create', as: :create_page
  get  'add', to: 'pages#new', as: :add_page

  resource :page, path: '*name', except: :new, as: :page do
    get 'add', to: 'pages#new', as: :new_page
  end
end
