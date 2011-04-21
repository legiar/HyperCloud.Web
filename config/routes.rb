HyperAdmin::Application.routes.draw do
  resources :network_addresses

  resources :networks

  resources :databases

  resources :slices

  resources :sites

  resources :customers

  resources :hosts

  devise_for :users do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
  end

  root :to => "dashboard#index"
end
