source 'https://rubygems.org'

gem 'activerecord-postgis-adapter'
gem 'acts-as-taggable-on' # A tagging plugin for Rails
gem 'ancestry'
gem 'authlogic' # For User Authentication
gem 'bcrypt' # Ruby binding for the OpenBSD bcrypt() password hashing algorithm
gem 'bourbon' # A Lightweight Sass Tool Set
gem 'browser' # Do some browser detection with Ruby
gem 'carrierwave', '~> 1.0' # provides a simple and extremely flexible way to upload files from Ruby applications
gem 'carrierwave-aws' # For using native AWS library for File Uploads
gem 'cells-rails'
gem 'cells-slim', git: "git@github.com:trailblazer/cells-slim", branch: :master
gem 'google-api-client', '~> 0.22'
gem 'i18n-js'
gem 'jwt' # A pure ruby implementation of the RFC 7519 OAuth JSON Web Token (JWT) standard
gem 'mini_magick' #gem for resize images
gem 'neat' # A lightweight and flexible Sass grid
gem 'oj' # A fast JSON parser and Object marshaller.
gem 'pg' # The PostgreSQL Adapter
gem 'puma', '~> 3.0' # Use Puma as the app server
gem 'rack-attack'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 5.1.0'
gem 'rails-i18n', '~> 5.1'
gem 'redis-namespace' # Use Redis with namespace, like with Sidekiq
gem 'redis-rails' # Use Redis for session and other stuff
gem 'rgeo-geojson'
gem 'role_model' # In order to use for Authorization
gem 'sass-rails'
gem 'sidekiq'
gem 'whenever', require: false
gem 'slim-rails' # Template language
gem 'uglifier' # For assets pipeline compression

group :development, :test do
  gem 'awesome_rails_console'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'brakeman', require: false
  gem 'closure-compiler'
  gem 'listen', '~> 3.0.5'

  gem 'rails-erd', require: false

  gem 'capistrano',             require: false
  gem 'capistrano-bundler',     require: false
  gem 'capistrano-inspeqtor',   require: false
  gem 'capistrano3-puma',       require: false
  gem 'capistrano-rails',       require: false
  gem 'capistrano-maintenance', require: false
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails', '~> 4.0'
  # I use this repo because a missing feature in the Faker gem,
  # I already open a PR: https://github.com/stympy/faker/pull/1067
  gem 'faker', git: "git@github.com:stympy/faker", branch: :master, require: false
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', require: false
end
