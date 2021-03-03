Rails.application.routes.draw do

  devise_for :customers, controllers: {
    registrations: 'customers/registrations'
  }
  root "homes#top"
  get 'homes/about'
  get 'settings/setting'
  resources :customers, only: [:show, :update, :index]
end
