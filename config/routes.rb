Rails.application.routes.draw do
  root to: "homes#top"
  get"/homes/about" => "homes#about" ,as: "about"
  devise_for :users
  resources :users, only: [:edit, :update,:index, :show]
  resources :books
end