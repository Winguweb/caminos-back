class Elements::ToastCell < Cell::ViewModel

  private

  def title
    model[:title]
  end

  def message
    model[:message]
  end

  def type
    model[:type]
  end

end
