class CreateOrganization
  prepend Service::Base
 
  def initialize(allowed_params)
    @allowed_params = allowed_params
    
  end

  def call
    create_organization
  end

  private

  def create_organization

    @organization = Organization.new(@allowed_params)
    return @organization if @organization.save
    errors.add_multiple_errors(@organization.errors.messages) && nil
  
  end

end
