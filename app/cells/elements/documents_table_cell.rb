class Elements::DocumentsTableCell < Cell::ViewModel

  private

  def documents
    @documents ||= model[:documents]
  end

end
