Rails.application.routes.draw do
  root "top#index"
  get "bad_request" => "top#bad_request"
  get "forbidden" => "top#forbidden"
  get "internal_server_error" => "top#internal_server_error"

  resources :categories do
    get "search", on: :collection
    resources :items do
      get "search", on: :collection
    end
  end

  resources :regulars do
    get "search", on: :collection
  end
  
  resources :members, only: [:index, :show] do
    get "search", on: :collection
    resources :orders
    resources :regulars do
      get "search", on: :collection
    end

  end
  resources :orders

  resource :session, only: [:create, :destroy]
  resource :account, except: [:destroy]
  resource :password, only: [:show, :edit, :update]


  namespace :admin do
    root "top#index"
    resource :session, only: [:create, :destroy]
    resource :password, only: [:show, :edit, :update]

    resources :categories do
      resources :items do
        get "search", on: :collection
      end
    end

    resources :regulars do
      get "search", on: :collection
    end
    resources :orders
    
    resources :members do
      get "search", on: :collection
      resources :orders
      resources :regulars do
        get "search", on: :collection
      end
    end
  end

end
