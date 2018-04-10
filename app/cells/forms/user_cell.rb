class Forms::UserCell < Cell::ViewModel
  include ::Cell::Translation

  private

  def user
    @user ||= model
  end

  def neighborhoods
    neighborhoods ||= options[:neighborhoods]
  end

  def neighborhood
    neighborhood ||= options[:neighborhood]
  end

  def url
    options[:url]
  end

  def action
    options[:action]
  end
end
