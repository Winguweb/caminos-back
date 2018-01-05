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

    @meeting = Meeting.new(@allowed_params)
    @meeting.neighborhood = @neighborhood
    return @meeting if @meeting.save
    errors.add_multiple_errors(@meeting.errors.messages) && nil
  
  end

  def work_params
    @allowed_params
  end
end
