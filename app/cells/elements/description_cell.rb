class Elements::DescriptionCell < Cell::ViewModel

  def show
    return unless text
    render
  end

  private

  def text
    @text ||= model[:text]
  end
end
