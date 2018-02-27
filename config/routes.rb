Rails.application.routes.draw do
  scope protocol: SECURE_PROTOCOL do

    root to: 'home#show'

  # ╭─ Public Accesible URL's / Path's
    get '/components', action: :index, controller: :components
    get '/admin', to: redirect('/admin/dashboard')
  # ╰─  End of Public Accesible URL's / Path's


  # ╭─ Private Accesible URL's / Path's
    namespace :admin do
      get  '/signin',   action: :new,     controller: :user_sessions
      post '/signin',   action: :create,  controller: :user_sessions
      post '/signout',  action: :destroy, controller: :user_sessions

      resources :users

      resource :dashboard, only: [:show]

      resources :organizations, only: [:show, :new, :create, :index]

      resources :neighborhoods, only: [:show, :new, :create, :index, :update, :edit] do
        resources :works, only: [:show, :new, :create, :index, :update,:edit]
        resources :meetings, only: [:show, :new, :create, :index, :update, :edit]
      end
    end
  # ╰─ End of Private Accesible URL's / Path's
  end
end
