Transport::Application.routes.draw do
  resources :users
  root 'static_pages#home'
  
  match '/help', to: 'static_pages#help', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  
end
