Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :shows, only: [:index, :show, :new, :create], param: :slug do
    get :search, on: :collection
    resource :subscription, only: [:create, :destroy]
  end

  resources :seasons, only: [] do
    resource :season_state, on: :member, only: [:update], path: :state, as: :state
  end

  resources :episodes, only: [] do
    resource :episode_state, on: :member, only: [:update], path: :state, as: :state
  end
end
