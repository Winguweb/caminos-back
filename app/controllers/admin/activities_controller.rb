module Admin
  class ActivitiesController < BaseController
    include CurrentAndEnsureDependencyLoader
    helper_method :current_neighborhood

    def index
      @activities =  []
      @auditables =  current_neighborhood.works +  current_neighborhood.meetings
      @auditables.each do  |auditable|
        auditable.audits.each  do |audit|
          @activities.push(audit)
        end
      end
    end
  end
end