class MobileElements::ResourcesCardCell < Cell::ViewModel
  include ::Cell::Translation

  def title
    model
  end

  def size
    options[:size]
  end

  def link
    options[:link]
  end

end
