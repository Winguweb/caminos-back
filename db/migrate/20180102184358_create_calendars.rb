class CreateCalendars < ActiveRecord::Migration[5.1]
 def change
    create_table :calendars,id: :uuid do |t|
      t.uuid :work_id, foreign_key: true
      t.uuid :meeting_id, foreign_key: true

      t.timestamps
    end
    add_index :calendars, :work_id
    add_index :calendars, :meeting_id
  end
end
