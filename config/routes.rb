Rails.application.routes.draw do
  root to: "homes#top"
  get"/home/about" => "homes#about" ,as: "about"
  devise_for :users
  resources :users, only: [:edit, :update,:index, :show] do
    resources :reading_logs, only: [:index]
    resource :relationships, only: [:create, :destroy]
     get "followers" => "relationships#followers", as: "followers"
  	 get "followeds" => "relationships#followeds", as: "followeds"
     get "daily_posts" => "users#daily_posts"
  end
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    resources :reviews, only: [:create, :destroy, :index]
    resource :reading_status, only: [:create, :update, :destroy] 
    resource :bookmark, only: [:create, :destroy]   
  end  
  get "search" => "searches#search"
  resources :rooms, only: [:create, :show] do      
    resources :messages, only: [:create]
  end
  resources :groups do
    resource :group_users, only: [:create, :destroy]
    resources :group_messages, only: [:new, :create, :destroy] 
  end
  get "tag_searches/search" => "tag_searches#search"
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  resources :notifications, only: [:update]
  resources :reading_logs        
end