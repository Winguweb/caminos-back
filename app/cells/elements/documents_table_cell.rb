class Elements::DocumentsTableCell < Cell::ViewModel

  private

  def documents
    model || []
  end

  def filters
    @filters ||= options[:filters]
  end
end
