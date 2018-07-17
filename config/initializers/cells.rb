require 'cell/translation'

Cell::ViewModel.class_eval do
  include ActionView::Helpers::TranslationHelper
  include ActionView::Helpers::FormOptionsHelper

  # Avoid http://trailblazer.to/gems/cells/troubleshooting.html#helper-inclusion-order
  include ApplicationHelper
end
