Rails.application.routes.draw do
  resources :users
  resource :session, :only=> [:new, :create, :destroy]

  resources :goals



end
