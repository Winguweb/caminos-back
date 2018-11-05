class CreateAsset < ActiveRecord::Migration[5.1]
  def change
    create_table :assets, id: :uuid do |t|
      t.uuid :neighborhood_id, null: false, index: true

      t.string :name
      t.text :description
      t.string :lookup_address

      t.geometry :geo_geometry, geographic: true
      t.geometry :geometry

      t.string :slug

      t.timestamps
    end
    add_index :assets, :slug
  end
end
