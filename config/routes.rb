Rails.application.routes.draw do

  devise_for :customers, controllers: {
    registrations: 'customers/registrations',
    sessions: 'customers/sessions'
  }
  root "homes#top"
  get 'homes/about'
  get 'setting' => "settings#setting", as: "setting"
  patch "customers/withdraw" => "customers#withdraw"
  resources :customers, only: [:show, :update, :index] do
    resource :relationships, only: [:create, :destroy]
    member do
      get :followings, :followers
    end
    resource :blocks, only: [:create, :destroy]
  end
  resources :diaries do
    resource :diary_favorites, only: [:create, :destroy]
    resources :diary_comments, only: [:create, :destroy]
  end
  resources :diet_methods do
    resource :diet_method_favorites, only: [:create, :destroy]
    resource :tries, only: [:create, :destroy]
    resources :diet_method_comments, only: [:create, :destroy]
  end
  resources :chats, only: [:create]
  get "chat/:id" => "chats#show", as: "chat"
end
