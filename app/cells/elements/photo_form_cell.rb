class Elements::PhotoFormCell < Cell::ViewModel

  private

  def files
    return [] if model.blank?
    model
  end
end