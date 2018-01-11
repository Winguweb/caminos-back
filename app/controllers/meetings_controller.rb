class MeetingsController < ApplicationController

  def show
    load_neighborhood
    load_meeting

  end
  
  def new
    load_neighborhood
    @meeting = Meeting.new
  end

  def create
    load_neighborhood
    service = CreateMeeting.call(meeting_params,@neighborhood)
    if service.success?
      redirect_to neighborhood_meetings_path
    else
      redirect_to  new_neighborhood_meeting_path(@neighborhood)
    end
  end

  def edit
    load_neighborhood
    load_meeting
  end

  def update
    load_neighborhood
    service = UpdateMeeting.call(load_meeting,meeting_params)
    if service.success?
      redirect_to neighborhood_meeting_path
    else
      redirect_to edit_neighborhood_meeting_path
    end
  end
  
  def index
    load_neighborhood
    @meetings = Meeting.all
  end
 
  private 

 
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

  def load_meeting
    @meeting = Meeting.find(params[:id])
  end

  def load_neighborhood
    @neighborhood = Neighborhood.find(params[:neighborhood_id])
  end
end
