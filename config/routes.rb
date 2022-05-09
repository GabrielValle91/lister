Rails.application.routes.draw do
    resources :list_items
    devise_for :users
    root 'home#index'
    get 'home/index'
    get 'about', to: 'home#about'
    resources :lists
end