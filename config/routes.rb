Rails.application.routes.draw do
  scope protocol: SECURE_PROTOCOL do

  # ╭─ Public Accesible URL's / Path's
    get  '/signin',   action: :new,     controller: :user_sessions
    post '/signin',   action: :create,  controller: :user_sessions
    post '/signout',  action: :destroy, controller: :user_sessions
  # ╰─ End of Public Accesible URL's / Path's

  # ╭─ Private Accesible URL's / Path's
    resources :users
    resources :neighborhoods do 
      resources :works
    end
    root to: 'home#show'
  # ╰─ End of Private Accesible URL's / Path's
  end
end
