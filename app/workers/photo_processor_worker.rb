class PhotoProcessorWorker
  include Sidekiq::Worker

  def perform(claim_id)

    claim = Claim.find_by(id: claim_id)

    photoToDelete = Photo.new

    claim.photos.each do | photo |

      next if photo.processed == true

      # Get stored image
      i = photo.image
      i.cache!

      # Change processed status
      photo.processed = true

      # Now image url changes to processed photo url
      # > model.processed? @ store_dir
      i.store!
      photo.save!

      # Get old temporal file and remove it
      photoToDelete.image.retrieve_from_store!(photo.image.filename)
      photoToDelete.image.remove!

    end

    claim.save!

  end
end
