class OrganizationsController < ApplicationController

  def show
    load_organization

  end
  
  def new
    @organization = Organization.new
  
  end

  def create
    service = CreateOrganization.call(organization_params)
    if service.success?
      redirect_to organizations_path
    else
      redirect_to new_organization_path
    end
  end

  def index
    @organizations = Organization.all

  end
  private 

 
  def organization_params
    params.require(:organization).permit(
      :description,
      :name
    )
  end

  def load_organization
    @organization = Organization.find(params[:id])
  end

end
