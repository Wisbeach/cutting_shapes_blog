Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions'
  }

  # Static route for the About page
  get 'about', to: 'pages#about'

  get 'shop', to: 'pages#shop'

  # Root route
  root 'posts#index'

  # Resource routes for posts
  resources :posts

  # Other routes...
end
