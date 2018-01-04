class CreateMeetings < ActiveRecord::Migration[5.1]
  def change
    create_table :meetings, id: :uuid do |t|
      t.date :date
      t.text :topics
      t.string :conveners
      t.text :objectives
      t.string :participants

      t.timestamps
    end
  end
end