Rails.application.routes.draw do

  devise_for :customers, controllers: {
    registrations: 'customers/registrations'
  }
  root "homes#top"
  get 'homes/about'
  get 'setting' => "settings#setting", as: "setting"
  resources :customers, only: [:show, :update, :index]
  resources :diaries
end
