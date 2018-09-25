module Admin
  class AgreementsController < BaseController
    include CurrentAndEnsureDependencyLoader
    include AgreementsUtils
    helper_method :current_neighborhood

    def create
      ensure_neighborhood; return if performed?

      service = CreateAgreement.call(current_neighborhood, agreement_params)

      if service.success?
        redirect_to admin_neighborhood_agreements_path
      else
        redirect_to new_admin_neighborhood_agreement_path
      end
    end

    def edit
      ensure_neighborhood; return if performed?

      load_agreement
      load_agreement_data
      load_agreement_indicators
    end

    def index
      ensure_neighborhood; return if performed?

      load_agreement
      load_agreement_data
    end

    def new
      ensure_neighborhood; return if performed?

      load_agreement
      load_agreement_indicators
    end

    def show
      ensure_neighborhood; return if performed?

      load_agreement
      load_agreement_data
    end

    def update
      ensure_neighborhood; return if performed?

      load_agreement
      service = UpdateAgreement.call(current_neighborhood, agreement_params, @agreement)

      if service.success?
        redirect_to admin_neighborhood_agreements_path
      else
        redirect_to edit_admin_neighborhood_agreemen_path
      end
    end

    private

    def load_agreement
      @agreement = current_neighborhood.agreement || Agreement.new
    end

    def load_agreement_data
      @agreement_data = parsed_agreement_data(@agreement)
    end

    def load_agreement_indicators
      @indicators = Agreement.indicators
    end

    def agreement_params
      params.require(:data).permit(
        i1: {},
        i2: {},
        i3: {},
        i4: {},
        i5: {},
        i6: {}
       )
    end
  end
end
