Rails.application.routes.draw do
  root "restros#index"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  resources :restros do
    resources :products, only: [:new, :create, :destroy]
  end

  post 'products/:id/add_to_cart', to: 'products#add_to_cart', as: 'add_to_cart'
  get 'cart', to: 'products#cart', as: 'cart'

  resources :payments, only: [:new, :create]
  get 'thanks', to: 'payments#thanks', as: 'thanks'
  # resources :orders, only: [:index]
  get 'my_orders', to: "orders#current_user_orders"

  get 'restro_owner', to: "restros#restro_owner"

  resources :users, only: [ :show ]
end
