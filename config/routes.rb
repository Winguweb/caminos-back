Rails.application.routes.draw do
  scope protocol: SECURE_PROTOCOL do

  # ╭─ Public Accesible URL's / Path's
    root to: 'home#index'

    get '/mobile', action: :mobile, controller: :home

    resources :neighborhoods, only: [:index, :show] do
      resources :works, only: [:show]
      resources :meetings, only: [:index, :show]
      member do
        get :agreement
        get :about
        get '/:filters', action: :show, controller: :neighborhoods, as: :filtered_work
      end
    end

    resources :works, only: [] do
      resources :meetings, only: [:index, :show]
    end

    resources :meetings, only: [] do
      resources :works, only: [:index]
    end

    get '/admin', to: redirect('/admin/dashboard')
  # ╰─  End of Public Accesible URL's / Path's


  # ╭─ Private Accesible URL's / Path's
    namespace :admin do
      get  '/signin',   action: :new,     controller: :user_sessions
      post '/signin',   action: :create,  controller: :user_sessions
      post '/signout',  action: :destroy, controller: :user_sessions

      # ╭─ AJAX Accesible URL's / Path's
      namespace :ajax do
        resources :neighborhoods, only: [] do
          # Documents Resource routes
          post '/documents/upload', action: :upload, controller: :documents
          delete '/documents/:id', action: :destroy, controller: :documents, as: :document
          resources :documents_relations, only: [:create, :destroy]

          # Photos Resources routes
          post '/photos/upload', action: :upload, controller: :photos
          delete '/photos/:id', action: :destroy, controller: :photos, as: :photo
        end
        resources :works, only: [] do
          # Documents Resource routes
          post '/documents/upload', action: :upload, controller: :documents
          delete '/documents/:id', action: :destroy, controller: :documents, as: :document
          resources :documents_relations, only: [:create, :destroy]

          # Photos Resources routes
          post '/photos/upload', action: :upload, controller: :photos
          delete '/photos/:id', action: :destroy, controller: :photos, as: :photo
        end
        resources :meetings, only: [] do
          # Documents Resource routes
          post '/documents/upload', action: :upload, controller: :documents
          delete '/documents/:id', action: :destroy, controller: :documents, as: :document
          resources :documents_relations, only: [:create, :destroy]
        end
      end
      # ╰─ End of AJAX Accesible URL's / Path's

      resources :users

      resource :dashboard, only: [:show]

      resources :organizations, only: [:show, :new, :create, :index]

      resources :neighborhoods, :as => "neighborhoods" do
        resources :works
        resources :meetings
        resource :agreement
      end
    end
  # ╰─ End of Private Accesible URL's / Path's
    namespace :api do
      resources :neighborhoods, :as => "neighborhoods" do
        get '/works/status/:status', action: :by_status, controller: :works
        get '/works/status', action: :index, controller: :works
        resources :works do
        end
      end
    end
  end
end
