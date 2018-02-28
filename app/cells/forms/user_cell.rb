class Forms::UserCell < Cell::ViewModel
  include ::Cell::Translation

  private

  def user
    @user ||= model
  end

  def url
    options[:url]
  end

  def action
    options[:action]
  end
end
