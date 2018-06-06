namespace :google_drive do

  namespace :sync do

    desc 'Sync Neighborhoods Google Drive Folders'
    task neighborhoods_folders: :environment do
      neighborhoods = Neighborhood.with_gdrive_folder

      neighborhoods.each do |neighborhood|
        SyncGoogleDriveFolderWorker.perform_in(rand(1..10).minutes, neighborhood.id)
      end
    end
  end
end

