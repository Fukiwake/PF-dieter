Rails.application.routes.draw do
  devise_for :customers
  get 'homes/top'
  get 'homes/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homes#top"
end
