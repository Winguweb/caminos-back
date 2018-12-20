class ChangeOwnerNullabilityFromPhotos < ActiveRecord::Migration[5.1]
  def change
    change_column_null :photos, :owner_type, true
    change_column_null :photos, :owner_id, true
    change_column_null :photos, :uploader_id, true
  end
end
