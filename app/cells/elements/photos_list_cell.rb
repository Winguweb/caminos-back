class Elements::PhotosListCell < Cell::ViewModel
  include ::Cell::Translation

  private

  def photos
    @photos ||= model
  end
end
