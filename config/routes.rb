Transport::Application.routes.draw do
  get "users/new"
  root 'static_pages#home'
  
  match '/help', to: 'static_pages#help', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  
end
