class Section::FooterLinkCell < Cell::ViewModel

  def show
    return unless link
    render
  end

  private

  def link
    @link ||= model
  end

  def extra_classes
    options[:extra_classes]
  end
end
