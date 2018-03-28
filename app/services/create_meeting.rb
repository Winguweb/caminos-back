class CreateMeeting
  prepend Service::Base

  def initialize(neighborhood, allowed_params)
    @neighborhood = neighborhood
    @allowed_params = allowed_params
  end

  def call
    create_meeting
  end

  private

  def create_meeting
    meeting = @neighborhood.meetings.new(meeting_params)

    if documents_params.present? 
      documents_params.each do |document|
        service_document = SaveDrive.call(document[:link],document[:name])
        if (service_document.success?)
          document =  meeting.documents.new(name:document[:name], description:document[:description], attachment_source:service_document.result. alternate_link)
          document.holder = meeting
        end
      end
      
      return meeting if meeting.save

      errors.add_multiple_errors(meeting.errors.messages) && nil
      
    else
      return meeting if meeting.save

      errors.add_multiple_errors(meeting.errors.messages) && nil
    end

   
  end

  # def meeting_params
  #   @allowed_params.merge(works: works)
  # end
  def meeting_params
    {
      date: @allowed_params[:date],
      lookup_address: @allowed_params[:lookup_address],
      lookup_coordinates: @allowed_params[:lookup_coordinates],
      objectives: @allowed_params[:objectives],
      minute: @allowed_params[:minute],
      organizer: @allowed_params[:organizer],
      participants: @allowed_params[:participants],
      works: works
    }
  end

  def works
    return [] if @allowed_params[:works].blank?
    @neighborhood.works.where(id: @allowed_params[:works])
  end

  def documents_params
    documents = []
    @allowed_params[:documents].each do |doc|
      documents.push(doc) if !doc[:link].blank?
    end
    documents
  end

end

