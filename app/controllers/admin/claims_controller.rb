module Admin
  class ClaimsController < BaseController
    include CurrentAndEnsureDependencyLoader
    include UsersHelper

    before_action :restrict_if_responsible, only: [:destroy]
    helper_method :current_neighborhood

    def edit
      ensure_neighborhood; return if performed?

      @verifications = Claim.verification_status
      load_claim
    end

    def index
      ensure_neighborhood; return if performed?

      @claims = current_neighborhood.claims.order(verification: :asc)
    end

    def show
      ensure_neighborhood; return if performed?

      load_claim
    end

    def update
      ensure_neighborhood; return if performed?

      load_claim
      service = UpdateClaim.call(@claim, claim_params)

      if service.success?
        redirect_to admin_neighborhood_claim_path
      else
        flash.now[:error] =  load_errors(service.errors)
        @verification_status = Claim.verification_status
        load_claim
        render action: :edit
      end
    end

    def destroy
      ensure_neighborhood; return if performed?

      load_claim

      if @claim.destroy
        redirect_to admin_neighborhood_claim_path(current_neighborhood)
      else
        redirect_back(fallback_location: admin_dashboard_path)
      end
    end

    private

    def load_errors(errors)
      messages  = []
      errors.each do |error|
        messages << t('admin.claims.errors', field: t("claims.#{error}"))
      end
      return messages
    end

    def load_claim
      @claim = current_neighborhood.claims.friendly.find(params[:id])
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
        :date,
        :verification,
        photos: [[:image]],
      )
    end

  end
end
