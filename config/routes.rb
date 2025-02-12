Rails.application.routes.draw do
  use_doorkeeper


  root to: "home#index"

  get :ping, to: ->(env) { [ "200", { "Content-Type" => "text/plain" }, [ "pong" ] ] }

  namespace :api do
    namespace :v1 do
      resource :user, only: [ :show ]
      namespace :shows do
        resources :subscriptions, only: [ :index ]
        resources :unseen, only: [ :index ]
        resources :upcoming, only: [ :index ]

        scope ":show_slug" do
          resources :episodes, only: [ :index ]
        end
      end
    end
  end

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
