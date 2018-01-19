class CreateJoinTableMeetingWork < ActiveRecord::Migration[5.1]
  def change
    create_table :meetings_works, id: false do |t|
      t.uuid :meeting_id
      t.uuid :work_id
    end
    add_index :meetings_works, :work_id
    add_index :meetings_works, :meeting_id
    add_index :meetings_works, [:meeting_id, :work_id]
  end
end
