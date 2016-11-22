Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  root "static_pages#home"
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks#create"}
  mount Ckeditor::Engine => "/ckeditor"
  resources :reviews do
    resource :like
  end
  resources :comments, except: [:new, :index, :show]
  namespace :admin do
    root "users#index", as: "root"
    resources :users, only: [:index, :show, :destroy]
    resources :category_tours
    resources :confirm_reviews, only: [:edit, :update]
    resources :category_reviews do
      resources :reviews, only: [:index, :destroy]
    end
    resources :tours do
      resources :book_tours, only: [:index, :destroy]
    end
    resources :users, only: [:index, :show, :destroy]
  end
  resources :tours, only: [:index, :show]
  resources :book_tours
  resources :activities
  resources :users, only: [:show, :index]
end
