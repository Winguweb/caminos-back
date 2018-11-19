class UpdateAsset
  prepend Service::Base

  def initialize(asset, allowed_params)
    @allowed_params = allowed_params
    @asset = asset
  end

  def call
    update_asset
  end

  private

  def update_asset
    return @asset if @asset.update(@allowed_params)
    errors.add_multiple_errors(@asset.errors.messages) && nil
  end

end


