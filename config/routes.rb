Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json } do #to specify the default format
      resources :users do
        resources :posts, only: [:index] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "users#index"
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show] do
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create]
    end
  end
  resources :posts, only: [:new, :create, :destroy]
end
