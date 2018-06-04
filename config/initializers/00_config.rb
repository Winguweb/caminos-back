env = ENV['RAILS_ENV'] || Rails.env

ALLOWED_ORIGINS    = APP_CONFIG[env]['allowed_origins'].freeze

aws = APP_CONFIG[env]['aws'].freeze
AWS_CREDENTIALS = aws['credentials'].freeze
AWS_REGION      = aws['region'].freeze
AWS_S3_BUCKET   = aws['s3']['bucket'].freeze

google = APP_CONFIG[env]['google'].freeze
DRIVE_API_KEY = google['drive']['api_key']

HOSTNAME = APP_CONFIG[env]['hostname'].freeze

MAPBOX_TOKEN    = APP_CONFIG[env]['mapbox']['token'].freeze

redis = APP_CONFIG[env]['redis'].freeze
REDIS_DB   = redis['db'].freeze
REDIS_HOST = redis['host'].freeze
REDIS_PORT = redis['port'].freeze
REDIS_URL  = "redis://#{REDIS_HOST}:#{REDIS_PORT}/#{REDIS_DB}".freeze
$redis = Redis.new(host: REDIS_HOST, port: REDIS_PORT)

SSL_ENABLED     = APP_CONFIG[env]['ssl_enabled'].freeze
SECURE_PROTOCOL = (SSL_ENABLED ? 'https' : 'http').freeze
