class Elements::MeetingsListCell < Cell::ViewModel

  include ::Cell::Translation

  private

  def meetings
    @meetings ||= model
  end

  def admin
    options[:admin]
  end

end
