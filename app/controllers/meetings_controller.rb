class MeetingsController < ApplicationController
  include CurrentAndEnsureDependencyLoader
  helper_method :current_neighborhood

  before_action :check_for_mobile, only: %i[index show]

  helper_method :current_meetable

  def index
    load_meetings
    @meetings_years = @meetings.group_by { |x| x.date.year }
  end

  def show
    @neighborhood = current_neighborhood
    load_meeting
  end

  private

  def current_meetable
    return @current_meetable if defined? @current_meetable

    @current_meetable = current_neighborhood || current_work

    (redirect_back(fallback_location: root_path) and return) unless @current_meetable

    @current_meetable
  end

  def load_meeting
    @meeting = current_meetable.meetings.find_by(id: params[:id])
  end
  def load_meetings
    @meetings = current_meetable.meetings.reverse
  end
end
