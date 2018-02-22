class Elements::MeetingDetailsCell < Cell::ViewModel

  private

  def meeting
    @meeting ||= model
  end

end
