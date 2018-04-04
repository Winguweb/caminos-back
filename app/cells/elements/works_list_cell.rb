class Elements::WorksListCell < Cell::ViewModel
  include ::Cell::Translation

  private

  def works
    @works ||= model
  end

end
