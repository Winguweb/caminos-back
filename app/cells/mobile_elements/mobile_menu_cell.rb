class MobileElements::MobileMenuCell < Cell::ViewModel
  include ::Cell::Translation

  def show
    return render :back_menu if back_menu
    render :show
  end

  def neighborhood
    return [] if model.blank?
    model
  end

  def with_links
    options[:with_links].blank? ? '' : 'with-links'
  end

  def back_menu
    options[:back_menu]
  end

  def back_url
    options[:back_url] || 'javascript:history.back()'
  end

  def section
    params[:action]
  end
end
