Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :welcome, only:[:index]
  root "welcome#index"
  resources :posts, only:[:index,:show,:create]
  resources :likes, only:[:create]
  resources :users, only:[:update,:index,:show]
  resources :relationships, only:[:create,:update]
  resources :rooms, only:[:create,:show]
  
  resources :events do
    member do
      patch 'replace'
    end
  end
  
  resources :events, only:[:index,:create,:show,:edit,:update,:replace]
  resources :rooms, only:[:show]
  
  resources :messages do
    collection do
      post 'make'
    end
  end
  resources :messages, only:[:create,:make]
  
  resources :event_members do
    collection do
      post 'change'
    end
  end
  
  resources :event_members, only:[:create,:change]
end
