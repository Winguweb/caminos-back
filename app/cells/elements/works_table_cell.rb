class Elements::WorksTableCell < Cell::ViewModel

  private

  def works
    @works ||= model
  end

  def neighborhood
    @neighborhood ||= options[:neighborhood]
  end

end
