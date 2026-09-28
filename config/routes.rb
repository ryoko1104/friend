Rails.application.routes.draw do
  devise_for :users, controllers: {
   registrations: "users/registrations"
  }
  resources :users, only: [:show]

  resources :tweets do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  root "tweets#index"

  delete 'tweets/:id' => 'tweets#destroy'
  
end