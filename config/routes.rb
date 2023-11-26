Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions'
  }

  # Static route for the About page
  get 'about', to: 'pages#about'

  get 'shop', to: 'pages#shop'
  get 'contact', to: 'pages#contact', as: 'contact'

  # Root route
  root 'posts#index'
  get 'posts/manage', to: 'posts#manage', as: 'manage_posts'
  post 'posts/bulk_delete', to: 'posts#bulk_delete', as: 'bulk_delete_posts'

  # Resource routes for posts
  resources :posts

  # Other routes...
end
