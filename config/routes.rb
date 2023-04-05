Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/", to: "landing#index"

  resources :users, only: [:new, :show] do
    resources :discover, only: [:index]
      resources :movies, only: [:index, :show] do
        resources :viewing_party, only: [:new, :create]
      end
  end

  get '/register', to: "users#new"
  post '/register', to: "users#create"
 
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'

  get '/logout', to: 'users#logout'

  get '/dashboard', to: 'users#show'
end
