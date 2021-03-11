Rails.application.routes.draw do

  devise_for :admin, controllers: {
    sessions: 'admins/sessions',
  }
  devise_for :customers, controllers: {
    registrations: 'customers/registrations',
    sessions: 'customers/sessions',
    omniauth_callbacks: 'customers/omniauth_callbacks'
  }
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#new_guest'
  end
  root "homes#top"
  get 'homes/about'
  get 'setting' => "settings#setting", as: "setting"
  resources :notifications, only: [:index]
  patch "notifications/checked" => "notifications#checked"
  patch "customers/withdraw" => "customers#withdraw"
  patch "customers/notification_setting" => "customers#notification_setting"
  resources :customers, only: [:show, :update, :index] do
    resource :relationships, only: [:create, :destroy]
    member do
      get :followings, :followers
    end
    resource :blocks, only: [:create, :destroy]
    collection do
      get :ranking
    end
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
  resources :contacts, only: [:new, :create]
  resources :reports, only: [:create]

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update] do
      collection do
        patch "withdraw_all"
      end
    end
    resources :diaries, only: [:index, :show, :edit, :update] do
      collection do
        patch "destroy_all"
      end
    end

    resources :contacts, only: [:index, :show, :update]

  end
end
