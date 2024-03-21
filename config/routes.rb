Rails.application.routes.draw do
  #devise_for :users do
  #  get '/users/sign_out' => 'devise/sessions#destroy'
  #end

  #devise_for :users, controllers: {
    #registrations: 'users/registrations'
  #}

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "articles#index"
  

  resources :articles do
    resources :comments
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
