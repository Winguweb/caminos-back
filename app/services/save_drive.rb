class SaveDrive
  prepend Service::Base

  def initialize(link)
    @link = link
    
  end

  def call
    SaveDrive(@link)
  end

  private

  def SaveDrive(link)
    drive = Google::Apis::DriveV2::DriveService.new
    drive.authorization = authorize
    #TO-DO ver permisos del doc
    #
    begin
      file = drive.update_file(link.split('/').last,add_parents: '1GbnOmGFwblF0Wc3NuUnSetaus_1T38nZ',fields: 'id, parents')
      return file
    rescue
      return errors.add(:messages, "Invalid credentials") && nil
    end
    
  end

  def authorize
    oob_uir = 'urn:ietf:wg:oauth:2.0:oob'
    scope = Google::Apis::DriveV2::AUTH_DRIVE
    FileUtils.mkdir_p(File.dirname(File.join(Dir.home, '.credentials',"drive-ruby-quickstart.yaml")))
    client_id = Google::Auth::ClientId.new(GOOGLE_CLIENT_ID,GOOGLE_CLIENT_SECRET)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: File.join(Dir.home, '.credentials',"drive-ruby-quickstart.yaml"))
    authorizer = Google::Auth::UserAuthorizer.new(
      client_id, scope, token_store)
    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)
    if credentials.nil?
      url = authorizer.get_authorization_url(base_url: oob_uir)
      puts "Open the following URL in the browser and enter the " +
           "resulting code after authorization"
      puts url
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(user_id: user_id, code: code, base_url: oob_uir)
    end
    credentials
  end
 
end
