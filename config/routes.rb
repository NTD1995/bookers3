Rails.application.routes.draw do
  get 'group_messages/new'
  get 'group_messages/create'
  get 'group_messages/destroy'
  root to: "homes#top"
  get"/home/about" => "homes#about" ,as: "about"
  devise_for :users
  resources :users, only: [:edit, :update,:index, :show] do
    resource :relationships, only: [:create, :destroy]
     get "followers" => "relationships#followers", as: "followers"
  	 get "followeds" => "relationships#followeds", as: "followeds"
     get "daily_posts" => "users#daily_posts"
  end
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end  
  get "search" => "searches#search"
  resources :rooms, only: [:create, :show] do      
    resources :messages, only: [:create]
  end
  resources :groups do
    resource :group_users, only: [:create, :destroy]
    resources :group_messages, only: [:new, :create, :destroy] 
  end    
end