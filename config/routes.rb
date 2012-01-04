HyperCloud::Application.routes.draw do
  devise_for :users
  resources :users do
    member do
      get 'approve'
      get 'reject'
    end
  end
  
  resources :customers
  
  resources :hosts
  resources :slices
  resources :sites
  resources :databases
  
  #namespace :dns do
  #  resources :domains do
  #    resources :records
  #  end
  #  resources :supermasters
  #end

  #resources :conditions

  #resources :queue_tasks
  #resources :queue_jobs do
  #  collection do
  #    post "reorder"
  #  end
  #  member do
  #    get 'cancel'
  #  end
  #end
  #resources :tasks
  #resources :jobs
  #resources :products
  #resources :network_addresses
  #resources :networks

  get "dashboard", :controller => :dashboard, :action => :index

  root :to => "dashboard#index"
end
