module ApplicationHelper
  include LayoutHelper

  def current_class?(test_path)
    return 'active' if current_page?(test_path)
    ''
  end
end
