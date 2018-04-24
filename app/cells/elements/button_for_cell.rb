class Elements::ButtonForCell < Cell::ViewModel

  private

  def title
    model[:title]
  end

  def for_element
    model[:for]
  end
end
