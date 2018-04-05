class UpdateProfile
  prepend Service::Base

  def initialize(profile, profile_params)
    @profile = profile
    @profile_params = profile_params
  end

  def call
    update_profile
  end

  private

  def update_profile
    @profile.assign_attributes( @profile_params )

    return @profile if !@profile.changed? || @profile.save

    errors.add_multiple_errors(@profile.errors.messages) && nil
  end

end
