class CreateResponsibles < ActiveRecord::Migration[5.1]
  def change
    create_table :responsibles,id: :uuid do |t|
      t.uuid :neighborhood_id, foreign_key: true
      t.uuid :user_id, foreign_key: true

      t.timestamps
    end
    add_index :responsibles, :neighborhood_id
    add_index :responsibles, :user_id
  end
end
