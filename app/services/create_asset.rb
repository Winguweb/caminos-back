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

    if !photo_params.nil?
      save_photos(@asset) if !photo_params.nil?

      return @asset if @asset.save
      errors.add_multiple_errors(@asset.errors.messages) && nil
    else
      return @asset if @asset.save
      errors.add_multiple_errors(@asset.errors.messages) && nil
    end


    # return @asset if @asset.save

    # errors.add_multiple_errors(@asset.errors.messages) && nil
  end

  def save_photos(claim)
    photo_params.each do |photo|
      new_photo =  claim.public_photos.new(photo)
      new_photo.owner = claim
    end
  end

  def photo_params
    return [] if @allowed_params[:photos].blank?
    @allowed_params[:photos]
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
