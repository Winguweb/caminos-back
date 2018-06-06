class SyncGoogleDriveFolderWorker
  include Sidekiq::Worker
  sidekiq_options queue: :high_priority

  def perform(neighborhood_id)
    neighborhood = Neighborhood.find(neighborhood_id)
    gdrive = neighborhood.google_drive_folder

    gdrive.root_folder_content(create_documents: true) if gdrive.valid?
  end

end
