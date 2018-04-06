module Admin
  class ActivitiesController < BaseController
    include CurrentAndEnsureDependencyLoader
    helper_method :current_neighborhood

    def index
      @activities =  []
      @works =  current_neighborhood.works
      @works.each do  |work|
        work.audits.each  do |audit|
          @activities.push(audit)
        end
      end
      #=  Audited::Audit.all

    end
  end
end