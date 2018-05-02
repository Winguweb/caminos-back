class MeetingsController < ApplicationController
  before_action :check_for_mobile, :only => [:index, :show]
  def index
    load_meetings
    @meetings_years = @meetings.group_by { |x| x.date.year }
  end

  def show
    load_meeting
  end

  private

  def load_meeting
    @meeting = Meeting.find_by(id: params[:id])
  end
  def load_meetings
    @meetings = Meeting.all.order(date: :desc)
  end
end
