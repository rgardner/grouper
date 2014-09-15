Rails.application.routes.draw do
  resources :users, only: [:new, :create]

  root 'users#new'
  match '/groups', to: 'static_pages#index', via: 'get'
end
