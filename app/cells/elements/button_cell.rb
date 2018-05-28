class Elements::ButtonCell < Cell::ViewModel

  private

  def extra_classes
    model[:extra_classes]
  end

  def title
    model[:title]
  end

  def url
    model[:url]
  end

  def action
    model[:action]
  end
end
