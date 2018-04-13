class Section::HeaderCell < Cell::ViewModel

  def show
    return unless section
    render
  end

  private

  def section
    @section ||= model
  end

  def subtitle
    options[:subtitle]
  end

  def links
    options[:links]
  end

  def buttons
    options[:buttons]
  end

  def custom_tag
    options[:custom_tag]
  end
end
