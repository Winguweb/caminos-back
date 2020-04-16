class HomeController < ApplicationController
  layout 'landing'
  include Reporting::Streamable
  def index
    @neighborhoods = Neighborhood.order('LOWER(name)')
  end

  def datasets; end

  def download
  	if params[:model].present?
      exporter_options = {
        data: params[:model].singularize.classify.constantize.all ,
      }
      reporter = "Reporting::#{params[:model]}Exporter".singularize.classify.constantize
      stream_csv(reporter, **exporter_options )
    end
  end
end
