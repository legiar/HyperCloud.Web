HyperCloud::Application.routes.draw do
  devise_for :users
  resources :users do
    member do
      get 'approve'
      get 'reject'
    end
  end
  
  resources :tickets, :shallow => true do
    resources :comments
  end
  
  resources :customers
  
  resources :hosts
  resources :slices
  resources :networks do
    resources :addresses, :controller => "NetworkAddresses"
  end
  #resources :network_addresses
  
  resources :sites do
    resources :instances, :controller => "SiteInstances", :only => [:show] do
      member do
        get "enable"
        get "disable"
      end
    end
  end
  resources :site_errors, :only => [:index, :show]
  
  resources :databases

  resources :pools

  get "dashboard", :controller => :dashboard, :action => :index
  root :to => "dashboard#index"

  constraints CanAccessResque do  
    mount Resque::Server, :at => "/resque"
  end  
end
