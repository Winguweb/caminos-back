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

    return @claim if @claim.save
    errors.add_multiple_errors(@claim.errors.messages) && nil
  end

  def claim_params
    {
      category_list: @allowed_params[:category_list],
      work_id: @allowed_params[:work_id],
      description: @allowed_params[:description],
      geo_geometry: @allowed_params[:geo_geometry],
      geometry: @allowed_params[:geometry],
      lookup_address: @allowed_params[:lookup_address],
      name: @allowed_params[:name],
    }
  end
end






