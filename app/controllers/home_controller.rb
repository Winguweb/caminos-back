class HomeController < ApplicationController

  def show
    @users = User.preload(:profile).all
  end
end
