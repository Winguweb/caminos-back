class Elements::PhotosGalleryCell < Cell::ViewModel

  private

  def photos
    return [] if model.blank?
    model
  end
end
