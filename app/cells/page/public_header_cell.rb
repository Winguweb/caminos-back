class Page::PublicHeaderCell < Cell::ViewModel
  include HeaderCellHelper
  include ::Cell::Translation

  private

  def neighborhood
    return [] if model.blank?
    model
  end

  def links
    options[:links]
  end

  def current_class?(test_path)
    return 'active' if current_page?(test_path)
    ''
  end
end
