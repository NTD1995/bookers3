Rails.application.routes.draw do
  root to: "homes#top"
  get"/home/about" => "homes#about" ,as: "about"
  devise_for :users
  resources :users, only: [:edit, :update,:index, :show] do
    resource :relationships, only: [:create, :destroy]
     get "followers" => "relationships#followers", as: "followers"
  	 get "followeds" => "relationships#followeds", as: "followeds"
  end
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end  
  get "search" => "searches#search"
end