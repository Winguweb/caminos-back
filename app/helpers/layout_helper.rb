module LayoutHelper
  include Admin::UsersHelper
  include ActionView::Helpers::UrlHelper

  def body_id
    if content_for?(:body_id)
      content_for(:body_id)
    else
      "#{controller.controller_name}-#{controller.action_name}"
    end
  end

  def body_class
    class_name = controller.controller_name
    if content_for?(:body_class)
      class_name = "#{class_name} #{content_for(:body_class)}"
    end

    class_name
  end

  def partial_exist?(partial_path)
    # TO-DO: Check if this is the best way to handle this issue about the _ (underscore) in the
    # partial name
    path = partial_path.split('/')
    partial_name = "_#{path.pop}"
    lookup_context.exists?("#{path.join('/')}/#{partial_name}")
  end

  def to_fixed_percentage(value)
    value.to_i.floor
  end

  def active_link_to(href, *args, &block)
    active_class = current_class?(href)
    link_class = args[0] && args[0][:class]
    added_classes = [] << active_class << link_class
    args[0] = (args[0] || {}).merge({:class => added_classes})
    link_to(href, *args , &block)
  end
end
