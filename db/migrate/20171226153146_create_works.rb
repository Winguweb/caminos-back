class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works, id: :uuid do |t|
      t.string :name
      t.string :status
      t.date :start_date
      t.date :end_date
      t.string :address
      t.geometry :location
      t.string :description
      t.string :budget
      t.string :manager
      t.string :execution_plan
      t.uuid :neighborhood_id, null: false, index: true
      t.timestamps
    end
  end
end
