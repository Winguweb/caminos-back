  env = ENV['RAILS_ENV'] || Rails.env

  GOOGLE_CLIENT_ID    = APP_CONFIG[env]['google_client_id'].freeze

  GOOGLE_CLIENT_SECRET = APP_CONFIG[env]['google_client_secret'].freeze
# class GOOGLE
#   env = ENV['RAILS_ENV'] || Rails.env

#   GOOGLE_CLIENT_ID    = APP_CONFIG[env]['google_client_id'].freeze

#   GOOGLE_CLIENT_SECRET = APP_CONFIG[env]['google_client_secret'].freeze

  # def initialize(n)    
  #   oob_uir = 'urn:ietf:wg:oauth:2.0:oob'
  #   scope = Google::Apis::DriveV2::AUTH_DRIVE

  #   FileUtils.mkdir_p(File.dirname(File.join(Dir.home, '.credentials',"drive-ruby-quickstart.yaml")))

  #   client_id = Google::Auth::ClientId.new(GOOGLE_CLIENT_ID,GOOGLE_CLIENT_SECRET)
  #   token_store = Google::Auth::Stores::FileTokenStore.new(file: File.join(Dir.home, '.credentials',"drive-ruby-quickstart.yaml"))
  #   authorizer = Google::Auth::UserAuthorizer.new(
  #     client_id, scope, token_store)
  #   user_id = 'default'
  #   credentials = authorizer.get_credentials(user_id)
  #   if credentials.nil?
  #     url = authorizer.get_authorization_url(
  #       base_url: oob_uir)
  #     puts "Open the following URL in the browser and enter the " +
  #          "resulting code after authorization"
  #     puts url
  #     code = gets
  #     credentials = authorizer.get_and_store_credentials_from_code(
  #       user_id: user_id, code: code, base_url: oob_uir)
  #   end
  #   credentials   
  # end
# end


