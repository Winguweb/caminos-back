class MobileElements::MeetingCardMobileCell < Cell::ViewModel

  private

  def meeting
    @meeting ||= model
  end

end
