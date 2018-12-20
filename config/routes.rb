Rails.application.routes.draw do
  devise_for :users
  resources :welcome, only:[:index]
  root "welcome#index"
  resources :posts, only:[:index,:show,:create]
end
