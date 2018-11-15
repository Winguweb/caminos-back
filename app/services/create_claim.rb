class CreateClaim
  prepend Service::Base

  def initialize(neighborhood, allowed_params, work=nil)
    @neighborhood = neighborhood
    @allowed_params = allowed_params
    @work = work
  end

  def call
    create_claim
  end

  private

  def create_claim
    @claim = Claim.new(claim_params)
    @claim.neighborhood = @neighborhood
    @claim.work = @work if @work != nil 

    
    if !photo_params.nil?
      save_photos(@claim) if !photo_params.nil?
    
      return @claim if @claim.save
      errors.add_multiple_errors(@claim.errors.messages) && nil

    else
      return @claim if @claim.save
      errors.add_multiple_errors(@claim.errors.messages) && nil
    end

    # return @claim if @claim.save

    # errors.add_multiple_errors(@claim.errors.messages) && nil
  end

  def save_photos(claim)
    photo_params.each do |photo|
      new_photo =  claim.public_photos.new(photo)
      new_photo.owner = claim
    end
  end

  def photo_params
    return  [] if @allowed_params[:photos].blank?
    @allowed_params[:photos]
  end


  def claim_params
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




 
 
