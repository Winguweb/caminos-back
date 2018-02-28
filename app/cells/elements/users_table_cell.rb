class Elements::UsersTableCell < Cell::ViewModel
  include ::Cell::Translation

  private

  def users
    @users ||= model
  end

  def filters
   @filters ||= options[:filters]
  end

end
