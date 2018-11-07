class ClaimsController < ApplicationController
  include CurrentAndEnsureDependencyLoader

   helper_method :current_neighborhood

   def create
    ensure_neighborhood; return if performed?
     service = CreateClaim.call(current_neighborhood, claim_params)
     # service = CreateClaim.call(current_neighborhood, claim_params,some_work)
     if service.success?
      redirect_to neighborhood_claims_path
    else
      flash.now[:error] =  load_errors(service.errors)
      @categories = Claim.categories
      @claim = current_neighborhood.claims.new(claim_params)
      render action: :new
    end
  end
  
  def show
    load_claim
    @neighborhood = @claim.neighborhood
  end

  def new
  end
  
  private
  
  def load_claim
    @claim = Claim.friendly.find(params[:id])
  end
  
  def claim_params
    params.require(:claim).permit(
      :category_list,
      :description,
      :geo_geometry,
      :geometry,
      :lookup_address,
      :name,
    )
  end
end