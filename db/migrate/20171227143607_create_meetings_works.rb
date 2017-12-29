class CreateMeetingsWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :meetings_works, id: :uuid do |t|
      t.uuid :work_id
      t.uuid :meeting_id
    end
    
    add_index :meetings_works, :work_id
    add_index :meetings_works, :meeting_id
  end
end
