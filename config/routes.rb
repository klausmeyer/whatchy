Rails.application.routes.draw do
  root to: "home#index"

  get :ping, to: ->(env) { [ "200", { "Content-Type" => "text/plain" }, [ "pong" ] ] }

  resources :activities, only: [ :index ]

  resource :profile, only: [ :show ]

  resources :subscriptions, only: [ :index ] do
    get :upcoming, on: :collection
  end

  resources :shows, only: [ :index, :show, :new, :create ], param: :slug do
    get :search, on: :collection

    scope module: :shows do
      resource :subscription, only: [ :create, :destroy ]
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
