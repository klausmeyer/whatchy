Rails.application.routes.draw do
  root to: "home#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :activities, only: [ :index ]

  resources :favourites, only: [ :index ]

  resource :profile, only: [ :show ]

  resources :subscriptions, only: [ :index ] do
    get :upcoming, on: :collection
  end

  resources :shows, only: [ :index, :show, :new, :create ], param: :slug do
    get :search, on: :collection

    scope module: :shows do
      resource :subscription, only: [ :create, :destroy ]
      resource :favourite, only: [ :create, :destroy ]
      resource :state, only: [ :update ]
    end
  end

  resources :seasons, only: [] do
    resource :state, only: [ :update ], module: :seasons
  end

  resources :episodes, only: [] do
    resource :state, only: [ :update ], module: :episodes
  end

  devise_for :users
end
