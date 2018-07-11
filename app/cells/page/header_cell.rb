class Page::HeaderCell < Cell::ViewModel
  include HeaderCellHelper

  def show
    return unless title
    render
  end

  def current_class?(test_path)
    return 'active' if current_page?(test_path)
    ''
  end

  private

  def title
    @title ||= model
  end

  def subtitle
    options[:subtitle]
  end

  def pretitle
    options[:pretitle]
  end

  def links
    options[:links]
  end

  def breadcrumbs
    options[:breadcrumbs]
  end
end
