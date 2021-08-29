Rails.application.routes.draw do
  get 'users/show'
 root to: 'homes#top'
 get 'home/about' => 'homes#about'
 devise_for :users
 resources :books, only: [:index, :create, :show, :destroy, :edit, :update]
 resources :users, only: [:index, :show, :edit, :update]
end
