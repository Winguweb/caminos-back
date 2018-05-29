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

  def work_url(id)
    return admin_neighborhood_work_path(id) if options[:admin]
    neighborhood_work_path(id)
  end

end
