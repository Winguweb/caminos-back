CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['S3_KEY_CAMINOS'],
      aws_secret_access_key: ENV['S3_SECRET_CAMINOS'],
      region:                ENV['S3_REGION_CAMINOS'],
  }
  config.fog_directory  = ENV['S3_BUCKET_CAMINOS']
end