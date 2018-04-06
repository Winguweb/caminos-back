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

    @work = Work.new(work_params)
    @work.neighborhood = @neighborhood

    if documents_params.present? || !photo_params.nil?
      save_photos(@work) if !photo_params.nil?
      save_documents(@work) if documents_params.present?
      return @work if @work.save
      errors.add_multiple_errors(@work.errors.messages) && nil

    else
      return @work if @work.save
      errors.add_multiple_errors(@work.errors.messages) && nil
    end
  end

  def save_photos(work)
    photo_params.each do |photo|
      photo =  work.photos.new(photo)
      photo.owner = work
    end
  end

  def save_documents(work)
   documents_params.each do |document|
      service_document = SaveDrive.call(document[:link],document[:name])
      if (service_document.success?)
        document =  work.documents.new(name:document[:name], description:document[:description], attachment_source:service_document.result. alternate_link)
        document.holder = work
      end
    end
  end

  def work_params
    {
      budget: @allowed_params[:budget],
      description: @allowed_params[:description],
      estimated_end_date: @allowed_params[:estimated_end_date],
      execution_plan: @allowed_params[:execution_plan],
      geometry: @allowed_params[:geometry],
      geo_geometry: @allowed_params[:geo_geometry],
      lookup_address: @allowed_params[:lookup_address],
      manager: @allowed_params[:manager],
      name: @allowed_params[:name],
      status: @allowed_params[:status],
      start_date: @allowed_params[:start_date],
    }
  end

  def photo_params
    return  [] if @allowed_params[:photos].blank?
    @allowed_params[:photos]
  end

  def documents_params
    return  [] if @allowed_params[:documents].blank?
    documents = []
    @allowed_params[:documents].each do |doc|
      documents.push(doc) if !doc[:link].blank?
    end
    documents
  end
end
