Rails.application.routes.draw do
  resources :users, only: [:new, :create]

  root 'users#new'
  match '/groups', to: 'groups#index', via: 'get'
end
