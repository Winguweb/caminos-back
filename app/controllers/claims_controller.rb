class ClaimsController < ApplicationController
  include CurrentAndEnsureDependencyLoader
  before_action :check_for_mobile, only: %i[show new]

  helper_method :current_neighborhood

   def create
    ensure_neighborhood; return if performed?
    service = CreateClaim.call(current_neighborhood, claim_params)

     # service = CreateClaim.call(current_neighborhood, claim_params,some_work)
    if service.success?
      link_photos(service.result)
      photos_tasks(service.result)
      flash.now[:success] = [t('.success')]
      flash.keep
      redirect_to mapping_neighborhood_path(current_neighborhood)
    else
      flash.now[:error] =  load_errors(service.errors)
      @categories = Claim.categories
      #TO-DO remove photos from params
      @claim = current_neighborhood.claims.new(claim_params.except(:photos))
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
    @claim = current_neighborhood.claims.new
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

  def link_photos(claim)
    photos = claim_params[:photos].map do | photo |
      Photo.find_by(id: photo)
    end
    claim.photos << photos
    claim.save!
  end

  def photos_tasks(claim)
    PhotoProcessorWorker.perform_async(claim['id'])
  end

  def claim_params
    params.require(:claim).permit(
      :category_list,
      :work_id,
      :description,
      :geo_geometry,
      :geometry,
      :lookup_address,
      :name,
      photos: [],
    )
  end
end
