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
  delete 'products/:id/remove_from_cart', to: 'products#remove_from_cart', as: 'remove_from_cart'
  get 'cart', to: 'products#cart', as: 'cart'

  resources :payments, only: [:new, :create]
  get 'thanks', to: 'payments#thanks', as: 'thanks'
  get 'my_orders', to: "orders#current_user_orders"
  post 'update_order_status', to: "orders#update_status"
  
  get 'restro_owner', to: "restros#restro_owner"
  get 'restros/:id/recent_orders', to: "restros#orders",as: 'recent_orders'

  resources :users, only: [ :show ] do
    get 'edit_name'
    patch 'update_name'
    
    get 'edit_address'
    patch 'update_address'
    
    get 'edit_phone_number'
    patch 'update_phone_number'

  end

  get 'search', to: 'searches#index'

  get 'deliveries', to: 'delivery_partners#index'
  get 'delivery_partners/current_deliveries', to: 'delivery_partners#current_deliveries'
  get 'delivery_partners/completed_deliveries', to: 'delivery_partners#completed_deliveries'

  post 'delivery_partners/accept_order', to: 'delivery_partners#accept_order', as: 'accept_order'
  post 'delivery_partners/complete_order', to: 'delivery_partners#complete_order', as: 'complete_order'

end
