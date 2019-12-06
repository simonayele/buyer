Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "products#index"



resource :cart, only: [:show]
resources :products
resources :orders
resources :order_items

end
