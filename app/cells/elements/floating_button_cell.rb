class Elements::FloatingButtonCell < Cell::ViewModel
  include ::Cell::Translation

  private

  def neighborhood
    @neighborhood ||= model
  end
end
