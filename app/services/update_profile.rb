class UpdateProfile
  prepend Service::Base

  def initialize(profile, profile_params, within_transaction = false)
    @profile = profile
    @profile_params = profile_params
    @within_transaction = within_transaction
  end

  def call
    update_profile
  end

  private

  def update_profile
    begin
      Profile.transaction do
        @profile.assign_attributes( @profile_params )

        @profile.save! if @profile.changed?
      end
    rescue ActiveRecord::RecordInvalid => e
      errors.add_multiple_errors( e.record.errors.messages )

      @within_transaction ? (raise Service::Error.new(self)) : (return nil)
    end

    @profile
  end

end
