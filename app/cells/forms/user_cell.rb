require 'cell/translation'

class Forms::UserCell < Cell::ViewModel
  include ::Cell::Translation
  include ActionView::Helpers::TranslationHelper
  include ActionView::Helpers::FormHelper

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
