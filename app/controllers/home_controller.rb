class HomeController < ApplicationController
  layout 'landing'

  def index; end

  def old_site
    redirect_to "https://mapeo-participativo.caminosdelavilla.org#{request.path}"
  end

end
