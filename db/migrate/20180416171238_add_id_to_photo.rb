class AddIdToPhoto < ActiveRecord::Migration[5.1]
  def up
    drop_table :photos
    create_table :photos, id: :uuid do |t|
      t.string :owner_type,null: false
      t.uuid :owner_id, null: false
      t.uuid :uploader_id, null: false

      # Stuff for the image file itself
      t.string :image
      t.string :original_filename
      t.string :content_type
      t.integer :file_size

      t.timestamps
    end
    add_index  :photos, [:owner_type, :owner_id]
  end

  # I create this down method in order to be able to rollback the migration
  # without the need to specify all this in the drop_table method
  def down
    drop_table :photos
    create_table :photos, id: false do |t|
      t.string :picture
      t.string :owner_type,null: false
      t.uuid :owner_id, null: false
      t.timestamps
    end
    add_index  :photos, [:owner_type, :owner_id]
  end
end
