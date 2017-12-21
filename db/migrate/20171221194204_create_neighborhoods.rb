class CreateNeighborhoods < ActiveRecord::Migration[5.1]
  def change
    create_table :neighborhoods, id: :uuid do |t|
      t.string :name
      t.text :description
      t.string :ambassador
      t.string :manager
      t.geometry :location

      t.timestamps
    end
  end
end
