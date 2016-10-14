Rails.application.routes.draw do
  resources :posts
  devise_for :users
  root to: 'static#homepage'
  get 'test', to: 'static#homepage'
end
