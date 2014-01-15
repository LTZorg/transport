Transport::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  root 'static_pages#home'
  

  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/help', to: 'static_pages#help',       via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  
end
