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

  def buttons_for
    options[:buttons_for]
  end

  def header_type
    options[:header_type]
  end

  def alert
    option[:alert]
  end
end
