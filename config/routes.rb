Rails.application.routes.draw do
  scope protocol: SECURE_PROTOCOL do

  # ╭─ Public Accesible URL's / Path's
    root to: 'home#index'

    resources :neighborhoods, only: %i[index show], path: "barrios" do
      resources :works, only: %i[show], path: "obras"
      resources :assets
      resources :meetings, only: %i[index show], path: "reuniones"
      member do
        # TODO: It should be routed to agreements controller
        get  :agreement, action: :show, controller: :agreements, path: "acuerdo"
        get :about, path: "acerca-del-barrio"
        get :mapping
      end
    end

    resources :works, only: [], path: "obras" do
      resources :meetings, only: %i[index show], path: "reuniones"
      resources :documents, only: %i[index], path: "documentos"
    end

    resources :meetings, only: [], path: "reuniones" do
      resources :works, only: %i[index], path: "obras"
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
          resources :documents_relations, only: %i[create destroy]

          # Photos Resources routes
          post '/photos/upload', action: :upload, controller: :photos
          delete '/photos/:id', action: :destroy, controller: :photos, as: :photo
        end
        resources :works, only: [] do
          # Documents Resource routes
          post '/documents/upload', action: :upload, controller: :documents
          delete '/documents/:id', action: :destroy, controller: :documents, as: :document
          resources :documents_relations, only: %i[create destroy]

          # Photos Resources routes
          post '/photos/upload', action: :upload, controller: :photos
          delete '/photos/:id', action: :destroy, controller: :photos, as: :photo
        end
        resources :meetings, only: [] do
          # Documents Resource routes
          post '/documents/upload', action: :upload, controller: :documents
          delete '/documents/:id', action: :destroy, controller: :documents, as: :document
          resources :documents_relations, only: %i[create destroy]
        end
      end
      # ╰─ End of AJAX Accesible URL's / Path's

      resources :users

      resource :dashboard, only: %i[show]

      resources :organizations, only: %i[show new create index]

      resources :neighborhoods, :as => "neighborhoods" do
        resources :works
        resources :meetings
        resource :agreement, except: %i[destroy]
      end
    end
  # ╰─ End of Private Accesible URL's / Path's
    namespace :api do
      resources :neighborhoods, :as => "neighborhoods" do
        get '/works/status/:status', action: :by_status, controller: :works
        get '/works/status', action: :index, controller: :works
      end
    end
  end
end
