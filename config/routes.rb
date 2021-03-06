Todo::Application.routes.draw do
  resources :users do 
    resources :lists, except: [:index]
  end

  resources :lists, only: [] do
    resources :items, only: [:create, :new]
  end

  resources :items, only: [:destroy]

  root to: 'users#new'

  namespace :api, defaults: {format: 'json'} do
    resources :users, only: [:create, :destroy]
    resources :lists, only: [:index, :show, :create, :destroy, :update] do
      resources :items, only: [:create, :destroy]
    end
  end
end
