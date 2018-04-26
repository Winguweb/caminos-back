Rails.application.routes.draw do
  scope protocol: SECURE_PROTOCOL do

  # ╭─ Public Accesible URL's / Path's
    root to: 'home#show'
    resources :neighborhoods, only: [:show] do
      member do
        get :agreement
        get :about
        resources :works, only: [:show]
        get '/(:filters)', action: :filtered, controller: :neighborhoods, as: :filtered_work
      end
    end
    get '/components', action: :index, controller: :components
    get '/admin', to: redirect('/admin/dashboard')
  # ╰─  End of Public Accesible URL's / Path's


  # ╭─ Private Accesible URL's / Path's
    namespace :admin do
      get  '/signin',   action: :new,     controller: :user_sessions
      post '/signin',   action: :create,  controller: :user_sessions
      post '/signout',  action: :destroy, controller: :user_sessions

      # ╭─ AJAX Accesible URL's / Path's
      namespace :ajax do
        post '/photos/upload', action: :upload, controller: :photos
        delete '/photos/:id', action: :delete, controller: :photos, as: :photo
      end
      # ╰─ End of AJAX Accesible URL's / Path's

      resources :users

      resource :dashboard, only: [:show]

      resources :organizations, only: [:show, :new, :create, :index]

      resources :neighborhoods, only: [:show, :new, :create, :index, :update, :edit] do
        resources :works, only: [:show, :new, :create, :index, :update, :edit]
        resources :meetings, only: [:show, :new, :create, :index, :update, :edit]
        resource :agreement, only: [ :show, :new, :create,:edit, :update]
      end
    end
  # ╰─ End of Private Accesible URL's / Path's
  end
end
