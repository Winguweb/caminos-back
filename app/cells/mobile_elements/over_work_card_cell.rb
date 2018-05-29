class MobileElements::OverWorkCardCell < Cell::ViewModel
  include ::Cell::Translation

  def work
    return [] if model.blank?
    model
  end
end
