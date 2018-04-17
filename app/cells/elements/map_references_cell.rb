class Elements::MapReferencesCell < Cell::ViewModel

  private

  def base
    return [] if model.blank?
    reference_number = 0
    model.map do |neighborhood|
      reference_number += 1
      {
          coordinates: neighborhood[:geometry].coordinates.first.map(&:reverse),
          className: 'base-geometry',
          reference: reference_number
      }
    end.to_json
  end

  def map_defaults
    MAP.merge(
      "marker_shadow_url" => image_url(MAP["marker_shadow_url"]),
      "marker_editable_url" => image_url(MAP["marker_editable_url"]),
    ).to_json
  end
end
