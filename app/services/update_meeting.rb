class UpdateMeeting
  prepend Service::Base

  def initialize(meeting,allowed_params)
    @allowed_params = allowed_params
    @meeting = meeting
  end

  def call
    update_meeting
  end

  private

  def update_meeting
    
    @meeting.update(meeting_params)
    return @meeting if @meeting.save
    errors.add_multiple_errors(@meeting.errors.messages) && nil
  end

  def meeting_params
    !@allowed_params[:works].nil? ? @meeting_params ||= @allowed_params.merge({ works: Work.find(work_params)}) :  @meeting_params ||= @allowed_params
  end

  def work_params
    @work_params ||= @allowed_params.delete('works')
  end

end


