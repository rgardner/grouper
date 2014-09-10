Rails.application.routes.draw do
  root 'static_pages#home'
  match '/signin', to: 'users#new', via: 'get'
end
