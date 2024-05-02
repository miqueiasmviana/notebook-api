Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  resource :auths, only: [:create]
  resources :kinds

  scope module: 'v1' do
    resources :contacts, :constraints => lambda { |request| request.params[:version] == "1"} do
      resource :kind, only: [:show]
      resource :kind, only: [:show], path: 'relationships/kind'

      resource :phones, only: [:show]
      resource :phones, only: [:show], path: 'relationships/phones'
      resource :phone, only: [:create, :update, :destroy]
      resource :phone, only: [:create, :update, :destroy], path: 'relationships/phones'

      resource :address, only: [:show, :create, :update, :destroy]
      resource :address, only: [:show, :create, :update, :destroy], path: 'relationships/address'
    end
  end

  scope module: 'v2' do
    resources :contacts, :constraints => lambda { |request| request.params[:version] == "2"} do
      resource :kind, only: [:show]
      resource :kind, only: [:show], path: 'relationships/kind'

      resource :phones, only: [:show]
      resource :phones, only: [:show], path: 'relationships/phones'
      resource :phone, only: [:create, :update, :destroy]
      resource :phone, only: [:create, :update, :destroy], path: 'relationships/phones'

      resource :address, only: [:show, :create, :update, :destroy]
      resource :address, only: [:show, :create, :update, :destroy], path: 'relationships/address'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
