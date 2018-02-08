class Elements::PersonCardCell < Cell::ViewModel

  private

  def person
    @person ||= model
  end

end
