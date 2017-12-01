env = ENV['RAILS_ENV'] || Rails.env

ALLOWED_ORIGINS    = APP_CONFIG[env]['allowed_origins'].freeze

HOSTNAME = APP_CONFIG[env]['hostname'].freeze

SSL_ENABLED     = APP_CONFIG[env]['ssl_enabled'].freeze
SECURE_PROTOCOL = (SSL_ENABLED ? 'https' : 'http').freeze
