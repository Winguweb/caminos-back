class MobileElements::MobileMenuCell < Cell::ViewModel
  include ::Cell::Translation

  def neighborhood
    return [] if model.blank?
    model
  end

  def links
    options[:links]
  end
end
