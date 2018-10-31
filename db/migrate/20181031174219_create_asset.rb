class CreateAsset < ActiveRecord::Migration[5.1]
  def change
    create_table :assets, id: :uuid do |t|
      t.string :titulo
      t.text :description
      t.string :address
      t.geometry :geo_polygon, geographic: true
      t.geometry :polygon

      t.string :slug, :string

      t.timestamps
    end
    add_index :assets, :slug
  end
end
