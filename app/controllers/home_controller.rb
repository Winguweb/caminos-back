class HomeController < ApplicationController
  layout 'public'

  def show
    if current_user
      redirect_to admin_dashboard_path
    end
  end

end
