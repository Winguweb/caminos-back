class Elements::WorksTreeCell < Cell::ViewModel
  include ::Cell::Translation

  private

  def works
    unordered_works = model
    @works = {}
    Work.categories.each do |category|
      @works[category] = unordered_works.select do |work|
        work.category.name == category
      end
    end
    @works
  end

  def neighborhood_id
    works.each do |category|
      first_work = category[1].first
      return first_work.neighborhood.id if first_work
    end
  end

end
