class UpdateNeighborhood
  prepend Service::Base

  def initialize(neighborhood, allowed_params)
    @neighborhood = neighborhood
    @allowed_params = allowed_params
  end

  def call
    update_neighborhood
  end

  private

  def update_neighborhood
    @neighborhood.assign_attributes( @allowed_params )

    if !@neighborhood.changed? || @neighborhood.save

      if gdrive_folder_changed? && @neighborhood.google_drive_folder.valid?
        SyncGoogleDriveFolderWorker.perform_async(@neighborhood.id)
      end

      return @neighborhood
    end

    errors.add_multiple_errors(@neighborhood.errors.messages) && nil
  end

  def gdrive_folder_changed?
    @neighborhood.previous_changes[:extras].present? &&
    @neighborhood.previous_changes[:extras].any?{|extra| extra && extra.keys.include?('gdrive_folder') }
  end

end


