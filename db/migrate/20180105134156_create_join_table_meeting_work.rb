class CreateJoinTableMeetingWork < ActiveRecord::Migration[5.1]
  def change
    create_join_table :meetings, :works do |t|
       t.index [:meeting_id, :work_id]
       t.index [:work_id, :meeting_id]
    end
  end
end
