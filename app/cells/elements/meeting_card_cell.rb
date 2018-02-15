class Elements::MeetingCardCell < Cell::ViewModel

  private

  def meeting
    @meeting ||= model
  end

end
