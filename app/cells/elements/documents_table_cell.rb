class Elements::DocumentsTableCell < Cell::ViewModel

  private

  def documents
    @documents ||= model[:documents]
  end
  
  def filters
    @filters ||= model[:filters]
  end
end
