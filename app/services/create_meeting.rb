class CreateMeeting
  prepend Service::Base

  def initialize(neighborhood, allowed_params)
    @neighborhood = neighborhood
    @allowed_params = allowed_params
  end

  def call
    create_meeting
  end

  private

  def create_meeting
    meeting = @neighborhood.meetings.new(meeting_params)

    return meeting if meeting.save

    errors.add_multiple_errors(meeting.errors.messages) && nil
  end

  def meeting_params
    @allowed_params.merge(works: works)
  end

  def works
    return [] if @allowed_params[:works].blank?

    @neighborhood.works.where(id: @allowed_params[:works])
  end
end
