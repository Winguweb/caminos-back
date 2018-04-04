class CreateWorks < ActiveRecord::Migration[5.1]
  # Change the limit of the text fields
  # The default value of limit is 65535, as expected.
  # 1 to 255 bytes: TINYTEXT (255 Bytes)
  # 256 to 65_535 bytes: TEXT (64 Kilobytes)
  # 65_536 to 16_777_215 bytes: MEDIUMTEXT (16 Megabytes)
  # 16_777_216 to 4_294_967_295 bytes: LONGTEXT (4 Gigabytes)
  # As explain in http://stackoverflow.com/questions/4443477/rails-3-migration-with-longtext

  TEXT_BYTES = 16_777_215

  def change
    create_table :works, id: :uuid do |t|
      t.uuid :neighborhood_id, null: false, index: true

      t.string :name
      t.text :description

      t.string :status
      t.date :start_date
      t.date :estimated_end_date
      t.date :end_date

      t.string :lookup_address
      t.st_point :lookup_coordinates, geographic: true
      t.geometry :geo_geometry, geographic: true
      t.geometry :geometry

      t.string :budget
      t.string :manager
      t.string :category
      t.string :organization

      t.text :execution_plan, limit: TEXT_BYTES

      t.timestamps
    end
    add_index :works, :lookup_coordinates, using: :gist
    add_index :works, :geo_geometry, using: :gist
    add_index :works, :geometry, using: :gist
  end
end
