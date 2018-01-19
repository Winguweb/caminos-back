class UpdateWork
  prepend Service::Base

  def initialize(work,allowed_params)
    @allowed_params = allowed_params
    @work = work
  end

  def call
    update_work
  end

  private

  def update_work
    
    @work.update(@allowed_params)
    return @work if @work.save
    errors.add_multiple_errors(@work.errors.messages) && nil
  end

end


