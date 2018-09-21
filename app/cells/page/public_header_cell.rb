class Page::PublicHeaderCell < Cell::ViewModel
  include ::Cell::Translation

  private

  def neighborhood
    return [] if model.blank?
    model
  end

  def neighborhoods
    Neighborhood.all
  end

  def links
    options[:links]
  end

  def current_class?(test_path)
    return 'active' if current_page?(test_path)
    ''
  end
end
