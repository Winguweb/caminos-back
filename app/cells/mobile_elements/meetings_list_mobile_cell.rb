class MobileElements::MeetingsListMobileCell < Cell::ViewModel

  include ::Cell::Translation

  private

  def meetings
    @meetings ||= model
  end

  def current_meetable
    options[:current_meetable]
  end

end
