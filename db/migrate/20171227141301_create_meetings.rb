class CreateMeetings < ActiveRecord::Migration[5.1]
  # Change the limit of the text fields
  # The default value of limit is 65535, as expected.
  # 1 to 255 bytes: TINYTEXT (255 Bytes)
  # 256 to 65_535 bytes: TEXT (64 Kilobytes)
  # 65_536 to 16_777_215 bytes: MEDIUMTEXT (16 Megabytes)
  # 16_777_216 to 4_294_967_295 bytes: LONGTEXT (4 Gigabytes)
  # As explain in http://stackoverflow.com/questions/4443477/rails-3-migration-with-longtext

  TEXT_BYTES = 16_777_215

  def change
    create_table :meetings, id: :uuid do |t|
      t.uuid :neighborhood_id, null: false, index: true

      t.date :date

      t.string :lookup_address
      t.st_point :lookup_coordinates, geographic: true

      t.text :objectives, limit: TEXT_BYTES
      t.text :minute, limit: TEXT_BYTES

      t.string :organizer
      t.string :participants

      t.timestamps
    end
    add_index :meetings, :lookup_coordinates, using: :gist
  end
end
