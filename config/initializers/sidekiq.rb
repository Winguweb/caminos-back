Sidekiq.configure_server do |config|
  config.redis = { url: REDIS_URL, :namespace => 'sk' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: REDIS_URL, :namespace => 'sk' }
end
