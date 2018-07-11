class Page::HeaderCell < Cell::ViewModel
  include ApplicationHelper

  def show
    return unless title
    render
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
