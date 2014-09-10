Rails.application.routes.draw do
  resources :people, only: [:new, :create]

  root 'people#new'
  match '/groups', to: 'static_pages#home', via: 'get'
end
