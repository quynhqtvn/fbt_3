Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks#create"}
  mount Ckeditor::Engine => "/ckeditor"
  resources :reviews do
    resources :comments
    resource :like
  end
  namespace :admin do
    root "users#index", as: "root"
    resources :users, only: [:index, :show, :destroy]
    resources :category_tours
    resources :confirm_review, only: [:edit, :update]
    resources :category_reviews do
      resources :reviews, only: [:index, :destroy]
    end
    resources :tours do
      resources :book_tours, only: [:index, :destroy]
    end
  end
  resources :tours, only: [:index, :show]
  resources :book_tours
end
