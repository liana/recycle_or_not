RecycleOrNot::Application.routes.draw do
  resources :games, :only => :index

  resources :materials

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end