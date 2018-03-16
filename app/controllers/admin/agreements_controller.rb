module Admin
  class AgreementsController < BaseController
    include CurrentAndEnsureDependencyLoader
    helper_method :current_neighborhood

    def show
      ensure_neighborhood; return if performed?
      load_agreement
      @data = eval(@agreement.data) if !@agreement.nil?
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
        redirect_to admin_neighborhood_agreement_path
      else
        redirect_to new_admin_neighborhood_agreement_path
      end
    end

    def index
      ensure_neighborhood; return if performed?

      @agreement = current_neighborhood.agreement
      @data = eval(@agreement.data) if !@agreement.nil?

    end


    private

    def load_agreement
      @agreement = current_neighborhood.agreement
    end
  end
end
