class Elements::BreadcrumbsCell < Cell::ViewModel

  private

  def crumbs
    @crumbs ||= model[:crumbs]
  end
end
