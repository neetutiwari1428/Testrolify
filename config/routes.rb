Rails.application.routes.draw do
  resources :forums
  resources :posts
  
  devise_for :users
  
  devise_scope :user do
    get 'password', to:'devise/passwords#edit' ,as: :edit_password
    patch 'password', to:'devise/passwords#update'

    get 'sign_up',to:'devise/registrations#new'
    post 'sign_up',to:'devise/registrations#create'
    
    get 'sign_in',to:'devise/sessions#new'
    post 'sign_in',to:'devise/sessions#create'

  
    
    get 'password/reset' ,to:'devise/password_resets#new'
    post 'password/reset' ,to:'devise/password_resets#create'
    get 'password/reset/edit' ,to:'devise/password_resets#edit'
    patch 'password/reset/edit' ,to:'devise/password_resets#update'

    delete 'log_out', to: 'devise/sessions#destroy'

  
    get 'user',to: 'users#new'
    post 'user',to: 'users#create'
    resources :users
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "users#index"
end
