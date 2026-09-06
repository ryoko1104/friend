Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show]
  
  resources :tweets do
    resources :comments, only: [:create]
  end

  root "tweets#index"

  delete 'tweets/:id' => 'tweets#destroy'
  
end