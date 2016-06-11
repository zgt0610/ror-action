Rails.application.routes.draw do

  get 'event_attendees/index'

  get 'event_attendees/show'

  get 'event_attendees/new'

  get 'event_attendees/edit'

  resources :people
  get "welcome/say_hello" => "welcome#say"
  get "welcome" => "welcome#index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # 外卡路由
  # match ':controller(/:action(/:id(.:format)))', :via => :all

  resources :events do
    collection do
      get :latest
      post :bulk_delete
      post :bulk_update
    end
    member do
      get :dashboard
    end
    resources :attendees, :controller => 'event_attendees'
    resource  :location,  :controller => 'event_locations'
  end

  resources :admin do
    resources :events
  end

  get "/zgt" => redirect("http://www.baidu.com")
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
