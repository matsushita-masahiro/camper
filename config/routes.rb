Rails.application.routes.draw do
  devise_for :users
  resources :welcome, only:[:index]
  root "welcome#index"
  resources :posts, only:[:index,:show,:create]
  resources :likes, only:[:create]
  resources :users, only:[:update]
  resources :relationships, only:[:create]
  resources :rooms, only:[:create,:show]
  resources :events, only:[:index,:create]
end
