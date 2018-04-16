class AddIdToPhoto < ActiveRecord::Migration[5.1]
  def change
    drop_table :photos
    create_table :photos, id: :uuid do |t|
      t.string :picture
      t.string :owner_type,null: false
      t.uuid :owner_id, null: false
      t.timestamps
    end
    add_index  :photos, [:owner_type, :owner_id]
  end
end
