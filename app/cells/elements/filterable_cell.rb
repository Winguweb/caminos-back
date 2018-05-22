class Elements::FilterableCell < Cell::ViewModel
  include ::Cell::Translation

  private

  def child
    data = options[:data].select do |record|
      options[:filters].blank? ? true : (options[:filters]).include?(record.category.name)
    end
    @child ||= cell(model, data)
  end

  def filters(new_filter = nil)
    return new_filter if options[:filters].blank?
    return remove_filters(categories) if new_filter == 'all_categories'
    return remove_filters(status) if new_filter == 'all_status'
    categories_filters = categories.include?(new_filter) ? new_filter : (categories & options[:filters]).join(',')
    status_filters = status.include?(new_filter) ? new_filter : (status & options[:filters]).join(',')
    [categories_filters, status_filters].reject(&:blank?).compact.join(',')
  end

  def remove_filters(filters_to_remove)
    options[:filters] - filters_to_remove
  end

  def categories
    ['all_categories'].concat(Work.categories)
  end

  def status
    ['all_status'].concat(Work.status)
  end

end
