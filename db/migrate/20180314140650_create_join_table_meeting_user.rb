class CreateJoinTableMeetingUser < ActiveRecord::Migration[5.1]
  def change
    create_table :meetings_users, id: false do |t|
      t.uuid :meeting_id
      t.uuid :user_id
    end
    add_index :meetings_users, :user_id
    add_index :meetings_users, :meeting_id
    add_index :meetings_users, [:meeting_id, :user_id]
  end
end