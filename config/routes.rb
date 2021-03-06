Money::Application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # resources :portal
  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'portal#index'

  ## versioning by path
  api_version(module: "Api", path: { value: "api" }, defaults: { format: 'json' }) do
    # namespace :api , defaults: {format: 'json'} do
      post 'upload' => 'monny#upload'
      get 'list' => 'monny#list'
      get 'query' => 'monny#query'
      get 'summary' => 'monny#summary'
      get 'trend' => 'monny#trend'
      get 'category' => 'monny#category'
    # end
  end
  
  ## versioning by header
  # api_version(module: "Api", default: true, header: { name: "Accept", value: "application/monny.v1" }, defaults: { format: 'json' }) do
  #   post 'upload' => 'monny#upload'
  #   get 'list' => 'monny#list'
  #   get 'query' => 'monny#query'
  #   get 'summary' => 'monny#summary'
  #   get 'trend' => 'monny#trend'
  #   get 'category' => 'monny#category'
  # end
  

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
