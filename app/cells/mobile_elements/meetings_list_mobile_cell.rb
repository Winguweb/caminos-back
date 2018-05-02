class MobileElements::MeetingsListMobileCell < Cell::ViewModel

  include ::Cell::Translation

  private

  def meetings
    @meetings ||= model
  end

end
