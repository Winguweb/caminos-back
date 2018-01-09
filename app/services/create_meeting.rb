class CreateMeeting
  prepend Service::Base
 
  def initialize(allowed_params,neighborhood)
    @allowed_params = allowed_params
    @neighborhood = neighborhood
    
  end

  def call
    create_meeting
  end

  private

  def create_meeting
    @meeting = Meeting.new(meeting_params)
    @meeting.neighborhood = @neighborhood
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
