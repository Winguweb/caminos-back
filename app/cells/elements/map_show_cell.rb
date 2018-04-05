class Elements::MapShowCell < Cell::ViewModel

  private

  def polygon
    return [] if model[:polygon].blank?
    model[:polygon].coordinates.first.map(&:reverse)
  end

  def markers
    return [] if options[:works].blank?
    options[:works].map do |work|
      {
        coordinates: work.geometry.coordinates,
        icon: image_path(work.category_icon)
      }
    end.to_json
  end

end
