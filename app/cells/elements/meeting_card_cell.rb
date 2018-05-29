class Elements::MeetingCardCell < Cell::ViewModel

  private

  def meeting
    @meeting ||= model
  end

  def meeting_url
    return admin_neighborhood_meeting_path(meeting.neighborhood, meeting) if options[:admin]
    neighborhood_meeting_path(meeting.neighborhood, meeting)
  end

end
