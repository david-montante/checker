Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users, only: [:new] do
    collection do
      post 'admin_create'
      get  'dashboard',        to: 'dashboard#index'
    end
  end

  resources :assists, only: [:index] do
    collection do
      get  'report'
      post 'check_in'
      post 'check_out'
    end
  end

  root 'home#index'
end
