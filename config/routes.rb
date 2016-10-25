Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  root "static_pages#home"
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks#create"}
  mount Ckeditor::Engine => "/ckeditor"
  resources :reviews do
    resources :comments
    resource :like
  end
  namespace :admin do
    root "users#index", path: "/"
    resources :users, only: [:index, :show, :destroy]
  end
  resources :tours, only: [:index, :show]
  resources :book_tours
end
