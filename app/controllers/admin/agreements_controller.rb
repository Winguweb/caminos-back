module Admin
  class AgreementsController < BaseController
    include CurrentAndEnsureDependencyLoader

    helper_method :current_neighborhood

    def show
      ensure_neighborhood; return if performed?
      load_agreement
      @data = eval(@agreement.data)
    end

    def new
      ensure_neighborhood; return if performed?
      @agreement = Agreement.new
      @indicators = Agreement.indicators
    end

    def create
      ensure_neighborhood; return if performed?
      service = CreateAgreement.call(current_neighborhood, params[:data])

      if service.success?
        redirect_to admin_neighborhood_agreements_path
      else
        redirect_to new_admin_neighborhood_agreement_path(current_neighborhood)
      end
    end

    def index
      ensure_neighborhood; return if performed?

      @agreement = current_neighborhood.agreement
      @data = eval(@agreement.data)
    end


    private

    def load_agreement
      @agreement = current_neighborhood.agreement
    end
  end
end
