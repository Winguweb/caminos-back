set :stage, :staging
set :branch, :staging

server 'stg18.caminos.wingu.ong', user: 'deploy', roles: %w{ app }

set :rails_env, :production
set :puma_env, :production
set :puma_config_file, "#{shared_path}/config/puma.rb"
set :puma_conf, "#{shared_path}/config/puma.rb"
