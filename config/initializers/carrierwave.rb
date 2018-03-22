env = ENV['RAILS_ENV'] || Rails.env
CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     APP_CONFIG[env]['s3_key'].freeze,
      aws_secret_access_key: APP_CONFIG[env]['s3_secret'].freeze,
      region:                APP_CONFIG[env]['s3_region'].freeze,
  }
  config.fog_directory  = APP_CONFIG[env]['s3_bucket'].freeze
end