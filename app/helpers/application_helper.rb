module ApplicationHelper
  include LayoutHelper

  def active_link_to(*args, &block)
    args_index = args[1].kind_of?(String) ? 2 : 1
    href = args[args_index-1]
    active_class = current_class?(href)
    link_class = args[args_index] && args[args_index][:class]
    added_classes = [] << active_class << link_class
    args[args_index] = (args[args_index] || {}).merge({:class => added_classes})
    link_to(*args , &block)
  end

  def current_class?(test_path)
    return 'active' if current_page?(test_path)
    ''
  end
end
