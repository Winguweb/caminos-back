class Elements::MeetingsListCell < Cell::ViewModel

  private

  def meetings
    @meetings ||= model
  end

end
