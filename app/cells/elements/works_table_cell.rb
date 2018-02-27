class Elements::WorksTableCell < Cell::ViewModel

  private

  def works
    @works ||= model[:works]
  end

  def filters
   @filters ||= model[:filters]
  end

  def neighborhood
    @neighborhood ||= options[:neighborhood]
  end

end
