class MobileElements::MobileMenuCell < Cell::ViewModel
  include ::Cell::Translation

  def neighborhood
    return [] if model.blank?
    model
  end

  def with_links
    options[:with_links].blank? ? '' : 'with-links'
  end

  def section
    params[:action]
  end
end
