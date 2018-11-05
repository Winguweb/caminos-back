class Page::PublicHeaderCell < Cell::ViewModel
  include ::Cell::Translation

  private

  def neighborhood
    return [] if model.blank?
    model
  end

  def neighborhoods
    Neighborhood.all.order('lower(name) ASC')
  end

  def urbanized
    options_from_collection_for_select(neighborhoods.where(urbanization: true), 'slug', 'name', neighborhood.slug)
  end

  def unurbanized
    options_from_collection_for_select(neighborhoods.where(urbanization: false), 'slug', 'name', neighborhood.slug)
  end

  def grouped_neighborhoods
    grouped_options = {
      'En proceso de urbanización' => urbanized,
      'Sin proceso de urbanización' => unurbanized
    }
    grouped_options_for_select(grouped_options)
  end

  def links
    options[:links]
  end

  def current_class?(test_path)
    return 'active' if current_page?(test_path)
    ''
  end
end
