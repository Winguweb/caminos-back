class CreateNeighborhood
  prepend Service::Base

  def initialize(allowed_params)
    @allowed_params = allowed_params
  end

  def call
    create_neighborhood
  end

  private

  def create_neighborhood
    @neighborhood = Neighborhood.new(neighborhood_params)
    @neighborhood.agreement = Agreement.new

    if @neighborhood.save

      if @neighborhood.google_drive_folder.valid?
        SyncGoogleDriveFolderWorker.perform_async(@neighborhood.id)
      end

      return @neighborhood
    end

    errors.add_multiple_errors(@neighborhood.errors.messages) && nil
  end

  def neighborhood_params
    @allowed_params
  end
end
