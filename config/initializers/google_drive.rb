  env = ENV['RAILS_ENV'] || Rails.env

  GOOGLE_CLIENT_ID    = APP_CONFIG[env]['google_client_id'].freeze

  GOOGLE_CLIENT_SECRET = APP_CONFIG[env]['google_client_secret'].freeze