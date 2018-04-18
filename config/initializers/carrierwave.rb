CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/uploads"

  config.storage    = :aws
  config.aws_acl    = "public-read"
  config.aws_bucket = AWS_S3_BUCKET

  # Optionally define an asset host for configurations that are fronted by a
  # content host, such as CloudFront.
  # config.asset_host = 'http://example.com'

  # The maximum period for authenticated_urls is only 7 days.
  config.aws_authenticated_url_expiration = 3600 # 1 Hour

  # Set custom options such as cache control to leverage browser caching
  config.aws_attributes = {
    expires: 1.week.from_now.httpdate,
    cache_control: "max-age=604800"
  }

  config.aws_credentials = {
    access_key_id:     AWS_CREDENTIALS["access_key"],
    secret_access_key: AWS_CREDENTIALS["secret_key"],
    region:            AWS_REGION,
    stub_responses:    Rails.env.test? # avoid hitting S3 actual during tests
  }
end
