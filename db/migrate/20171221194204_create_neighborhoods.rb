class CreateNeighborhoods < ActiveRecord::Migration[5.1]
  def change
    create_table :neighborhoods, id: :uuid do |t|
      t.string :name
      t.text :description
      t.geometry :location
    
      t.timestamps
    end

  end
end
