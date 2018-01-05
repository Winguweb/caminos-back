Rails.application.routes.draw do
  scope protocol: SECURE_PROTOCOL do

  # ╭─ Public Accesible URL's / Path's
    get  '/signin',   action: :new,     controller: :user_sessions
    post '/signin',   action: :create,  controller: :user_sessions
    post '/signout',  action: :destroy, controller: :user_sessions
  # ╰─ End of Public Accesible URL's / Path's

  # ╭─ Private Accesible URL's / Path's
    resources :users
    
    resources :organizations, only: [:show, :new, :create, :index]
    
    resources :neighborhoods, only: [:show, :new, :create, :index] do 
      resources :works, only: [:show, :new, :create, :index]
      resources :meetings, only: [:show, :new, :create, :index]
    end
    
    root to: 'home#show'

    resources :users, except: [ :index ]
  # ╰─ End of Private Accesible URL's / Path's
  end
end
