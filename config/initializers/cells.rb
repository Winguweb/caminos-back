require 'cell/translation'

Cell::ViewModel.class_eval do
  include ActionView::Helpers::TranslationHelper
end
