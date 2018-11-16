class ClaimsController < ApplicationController
  include CurrentAndEnsureDependencyLoader
  before_action :check_for_mobile, only: %i[show]
  
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
    ensure_neighborhood; return if performed?

    @categories = Claim.categories
    @work = current_neighborhood.works.new
  end

  private

  def load_errors(errors)
    messages  = []
    errors.each do |error|
      messages << t('.errors', field: t(".#{error}"))
    end
    return messages
  end

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
