class Elements::MeetingsCarouselCell < Cell::ViewModel

  private

  def meetings
    @meetings ||= model[:meetings]
  end

end
