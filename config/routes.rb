Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users do
    collection do
      get 'dashboard',        to: 'dashboard#index'
    end
  end

  root 'home#index'
end
