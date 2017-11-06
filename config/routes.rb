Rails.application.routes.draw do
  resource :login, only: [:new, :create, :destroy] do
    delete "logout", to: "logins#destroy"
  end
  resources :users, only: [:new, :create]
  resources :products, only: [:index]
  resource :cart, only: [:show] do
    post :buy, on: :collection
  end
  resources :order_items, only: [:create, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htm
  root to: "products#index"
end
