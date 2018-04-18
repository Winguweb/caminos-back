class Page::PublicHeaderCell < Cell::ViewModel
  include ::Cell::Translation

  private

  def neighborhood
    return [] if model.blank?
    model
  end

  def links
    options[:links]
  end
end
