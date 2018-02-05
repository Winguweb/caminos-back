class MeetingsController < ApplicationController
  include CurrentAndEnsureDependencyLoader

  helper_method :current_neighborhood

  def show
    ensure_neighborhood; return if performed?

    load_meeting
  end

  def new
    ensure_neighborhood; return if performed?

    @meeting = current_neighborhood.meetings.new
    @works = current_neighborhood.works
  end

  def create
    ensure_neighborhood; return if performed?

    service = CreateMeeting.call(current_neighborhood, meeting_params)

    if service.success?
      redirect_to neighborhood_meetings_path
    else
      redirect_to new_neighborhood_meeting_path(current_neighborhood)
    end
  end

  def index
    ensure_neighborhood; return if performed?

    @meetings = current_neighborhood.meetings
  end

  def edit
    ensure_neighborhood; return if performed?

    load_meeting
  end

  def update
    ensure_neighborhood; return if performed?

    load_meeting

    service = UpdateMeeting.call(@meeting, meeting_params)

    if service.success?
      redirect_to neighborhood_meeting_path(@meeting)
    else
      redirect_to edit_neighborhood_meeting_path(@meeting)
    end
  end

  private

  def load_meeting
    @meeting = current_neighborhood.meetings.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(
      :date,
      :minute,
      :objectives,
      :organizer,
      :participants,
      :lookup_address,
      works: []
     )
  end
end
