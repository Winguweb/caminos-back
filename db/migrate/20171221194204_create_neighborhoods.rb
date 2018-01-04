class CreateNeighborhoods < ActiveRecord::Migration[5.1]
  def change
    create_table :neighborhoods, id: :uuid do |t|
      t.string :name
      t.string :lookup_address
      t.st_point :lookup_coordinates, geographic: true

      t.text :description

      t.geometry :geo_polygon, geographic: true
      t.geometry :polygon

      t.timestamps
    end
    add_index :neighborhoods, :polygon, using: :gist
    add_index :neighborhoods, :lookup_coordinates, using: :gist
  end
end
