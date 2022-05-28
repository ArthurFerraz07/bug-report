Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#main'

  namespace :api do
    resources :users do
      collection do
        post :authenticate
      end
    end
  end
end
