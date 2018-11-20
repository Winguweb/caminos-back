class CreateClaim < ActiveRecord::Migration[5.1]
  
  def change
    create_table :claims, id: :uuid do |t|
      t.uuid :neighborhood_id, null: false, index: true
      t.uuid :work_id
      t.string :name
      t.text :description
      t.string :lookup_address
      t.geometry :geo_geometry, geographic: true
      t.geometry :geometry
      t.string :slug,
      t.timestamps
    end
    add_index :claims, :slug
    add_index :claims, :geo_geometry, using: :gist
    add_index :claims, :geometry, using: :gist
  end
end