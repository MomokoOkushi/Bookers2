Rails.application.routes.draw do
  devise_for :users
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end  
  resources :users, only: [:index, :show, :edit, :update]
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  get '/rooms/show/:id' => 'rooms#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
root to: "homes#top"
get '/home/about' => 'homes#about'


end
