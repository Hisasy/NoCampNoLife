Rails.application.routes.draw do

  devise_for :users

  get "" => "posts#index"
  get "users/quit" => "users#quit", as: "users_quit"
  patch "users/out" => "users#out", as: "users_out"

  resources :posts, only: [:new, :create, :show, :edit, :update, :destroy] do
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update] do
    member do
      get :likes
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

end
