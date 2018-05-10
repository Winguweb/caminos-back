class MobileElements::MeetingsNavigationMobileCell < Cell::ViewModel
  include ::Cell::Translation

  def meeting
    model
  end

  def get_next(meetable)
    data_index = index_of_meeting(meetable, meeting) + 1

    return if data_index >= meetings_data(meetable).size

    data = meetings_data(meetable)[data_index]
    url = send(:"#{meetable.class.name.downcase}_meeting_path", meetable, data[0])
    {id: data[0], date: data[1], url: url}
  end

  def get_previous(meetable)
    data_index = index_of_meeting(meetable, meeting) - 1

    return if data_index < 0

    data = meetings_data(meetable)[data_index]
    url = send(:"#{meetable.class.name.downcase}_meeting_path", meetable, data[0])
    {id: data[0], date: data[1], url: url}
  end

  def meetings_data(meetable)
    @meetings_data ||= meetable.meetings.pluck(:id, :date)
  end

  def index_of_meeting(meetable, meeting)
    @index_of_meeting ||= meetings_data(meetable).find_index{ |id, date| id == meeting.id }
  end

  def current_meetable
    options[:current_meetable]
  end
end
