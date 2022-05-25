Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#main'

  resources :users, only: %i[] do
    collection do
      get :login
      post :authenticate
    end
  end
end
