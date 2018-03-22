class CreateWork
  prepend Service::Base

  def initialize(neighborhood, allowed_params)
    @neighborhood = neighborhood
    @allowed_params = allowed_params
  end

  def call
    create_work
  end

  private

  def create_work

    @work = Work.new(@allowed_params)
    @work.neighborhood = @neighborhood
    return @work if @work.save
    errors.add_multiple_errors(@work.errors.messages) && nil

  end

  def work_params
    @allowed_params
  end

end


