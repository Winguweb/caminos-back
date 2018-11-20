class CreateAsset
  prepend Service::Base

  def initialize(neighborhood, allowed_params)
    @neighborhood = neighborhood
    @allowed_params = allowed_params
  end

  def call
    create_asset
  end

  private

  def create_asset
    @asset = Asset.new(asset_params)
    @asset.neighborhood = @neighborhood

    return @asset if @asset.save

    errors.add_multiple_errors(@asset.errors.messages) && nil
  end

  def asset_params
    {
      category_list: @allowed_params[:category_list],
      description: @allowed_params[:description],
      geo_geometry: @allowed_params[:geo_geometry],
      geometry: @allowed_params[:geometry],
      lookup_address: @allowed_params[:lookup_address],
      name: @allowed_params[:name],
    }
  end
end
