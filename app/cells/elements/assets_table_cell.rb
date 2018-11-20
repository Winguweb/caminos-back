class Elements::AssetsTableCell < Cell::ViewModel
  include ::Cell::Translation
  private

  def assets
    @assets ||= model
  end

  def filters
   @filters ||= options[:filters]
  end

  def neighborhood
    @neighborhood ||= options[:neighborhood]
  end

  def asset_url(id)
    return admin_neighborhood_asset_path(id) if options[:admin]
    neighborhood_asset_path(id)
  end

end
