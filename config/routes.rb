Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  resources :subscriptions, only: [:index]

  resources :shows, only: [:index, :show, :new, :create], param: :slug do
    get :search, on: :collection

    scope module: :shows do
      resource :subscription, only: [:create, :destroy]
      resource :state, only: [:update]
    end
  end

  resources :seasons, only: [] do
    resource :state, only: [:update], module: :seasons
  end

  resources :episodes, only: [] do
    resource :state, only: [:update], module: :episodes
  end
end
