class CreateNeighborhoodAgreement < ActiveRecord::Migration[5.1]
  def change
    create_table :agreements, id: :uuid do |t|
      t.uuid :neighborhood_id, null: false, index: true
      t.text :data
      t.timestamps
    end
  end
end
