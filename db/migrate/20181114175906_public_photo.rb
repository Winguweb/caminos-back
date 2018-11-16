class PublicPhoto < ActiveRecord::Migration[5.1]
  def change
  	create_table :public_photos, id: :uuid do |t|
      t.string :owner_type,null: false
      t.uuid :owner_id, null: false
   
      # Stuff for the image file itself
      t.string :image
      t.string :original_filename
      t.string :content_type
      t.integer :file_size

      t.timestamps
    end
    add_index  :public_photos, [:owner_type, :owner_id]
  end
end
