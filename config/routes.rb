Rails.application.routes.draw do
  resources :secrets, only: [:index, :create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:show, :create, :new, :edit, :update, :destroy]
  resources :likes, only: [:create, :destroy]
  #get 'users/new' => 'users#new'

  # get 'users/:user_id' => 'users#show'
  #
  # #get 'users/edit' => 'users#edit'
  #
  # get 'sessions/new' => 'sessions#new'
  #
  # post 'sessions' => 'sessions#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
