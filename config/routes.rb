Rails.application.routes.draw do

  devise_for :customers, controllers: {
    registrations: 'customers/registrations',
    sessions: 'customers/sessions'
  }
  root "homes#top"
  get 'homes/about'
  get 'setting' => "settings#setting", as: "setting"
  patch "customers/withdraw" => "customers#withdraw"
  resources :customers, only: [:show, :update, :index]
  resources :diaries do
    resource :diary_favorites, only: [:create, :destroy]
    resources :diary_comments, only: [:create, :destroy]
  end
  resources :diet_methods do
    resource :diet_method_favorites, only: [:create, :destroy]
    resource :tries, only: [:create, :destroy]
    resources :diet_method_comments, only: [:create, :destroy]
  end
end
