Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :shows, only: [:index, :show, :new, :create], param: :slug do
    get :search, on: :collection
    resource :subscription, only: [:create, :destroy]
  end
end
