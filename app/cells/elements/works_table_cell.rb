class Elements::WorksTableCell < Cell::ViewModel

  private

  def works
    @works ||= model[:works]
  end

  def neighborhood
    @neighborhood ||= options[:neighborhood]
  end

end
  