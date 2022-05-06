Rails.application.routes.draw do
    root 'home#index'
    get 'home/index'
    get 'about', to: 'home#about'
    resources :lists
end