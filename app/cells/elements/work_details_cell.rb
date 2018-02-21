class Elements::WorkDetailsCell < Cell::ViewModel

  private

  def work
    @work ||= model
  end

end
