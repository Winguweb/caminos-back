# It applies to classes where there is an optional
# soft destruction possibility. In this case, object
# gets a 'deleted_at' attribute set with a timestamp
# of deletion time, if certain conditions are meet
# returned by method +soft_destroy?+
module SoftDestroy
  extend ActiveSupport::Concern
  # Returns a new +Boolean+, true if the object could be
  # destroyed or false if there was any problem destroying
  # the object. Overrides the destroy method in order to
  # persist transaction history.

  included do
    scope :not_deleted, -> { where(deleted_at: nil) }
  end

  def soft_destroy?
    true
  end

  def destroy
    if soft_destroy?
      delete
    else
      run_callbacks(:destroy) { super }
    end
  end

  def delete
    return if new_record? or destroyed?
    update_attribute(:deleted_at, Time.now)
  end

  def restore!
    update_attributes(deleted_at: nil)
  end

  alias :restore :restore!

  def deleted?
    not deleted_at.nil?
  end

  def active?
    not deleted?
  end
end
