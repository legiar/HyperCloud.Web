HyperAdmin::Application.routes.draw do
  resources :queue_tasks
  resources :queue_jobs
  resources :tasks
  resources :jobs
  resources :products
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
  resources :users

  get "dashboard", :controller => :dashboard, :action => :index

  root :to => "dashboard#index"
end
