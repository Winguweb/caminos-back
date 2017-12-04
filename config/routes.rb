Rails.application.routes.draw do
  scope protocol: SECURE_PROTOCOL do
  # ╭─ Public Accesible URL's / Path's
    root to: 'home#show'
  # ╰─ End of Public Accesible URL's / Path's
  end
end
