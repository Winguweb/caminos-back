class CreateNeighborhoods < ActiveRecord::Migration[5.1]
  def change
    create_table :neighborhoods, id: :uuid do |t|
      t.string :name
      t.text :description
      t.boolean :urbanization, default: false
      t.text :delegates
      t.float :urbanization_score

      t.string :lookup_address
      t.st_point :lookup_coordinates, geographic: true

      t.geometry :geo_polygon, geographic: true
      t.geometry :polygon

      t.timestamps
    end
    add_index :neighborhoods, :lookup_coordinates, using: :gist
    add_index :neighborhoods, :geo_polygon, using: :gist
    add_index :neighborhoods, :polygon, using: :gist
  end
end
