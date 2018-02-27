require 'cell/translation'

class Elements::UsersTableCell < Cell::ViewModel
  include ::Cell::Translation
  include ActionView::Helpers::TranslationHelper

  private

  def users
    @users ||= model
  end

  def filters
   @filters ||= options[:filters]
  end

end
