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

end
