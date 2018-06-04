class Elements::ErrorMessagesCell < Cell::ViewModel

  def field_messages
    model || []
  end

  private

end
