class Elements::DocumentsTableCell < Cell::ViewModel
  include ::Cell::Translation

  private

  def documents
    model || []
  end

  def is_admin
    options[:admin]
  end
end
