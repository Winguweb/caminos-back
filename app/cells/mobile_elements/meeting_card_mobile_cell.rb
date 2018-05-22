class MobileElements::MeetingCardMobileCell < Cell::ViewModel

  private

  def meeting
    @meeting ||= model
  end

  def meeting_url
    @current_meetable = options[:current_meetable]
    send("#{@current_meetable.class.name.downcase}_meeting_path", @current_meetable, meeting)
  end

end
