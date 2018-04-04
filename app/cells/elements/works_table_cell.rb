class Elements::WorksTableCell < Cell::ViewModel
  include ::Cell::Translation

  private

  def works
    @works ||= model
  end

  def filters
   @filters ||= options[:filters]
  end

  def neighborhood
    @neighborhood ||= options[:neighborhood]
  end

end
