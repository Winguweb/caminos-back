class Elements::DocumentsTableCell < Cell::ViewModel
  include ::Cell::Translation

  private

  def documents
    model || []
  end

  def filters
    @filters ||= options[:filters]
  end
end
