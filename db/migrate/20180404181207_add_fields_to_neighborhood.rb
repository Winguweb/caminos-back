class AddFieldsToNeighborhood < ActiveRecord::Migration[5.1]
  def change
    add_column :neighborhoods, :urbanization, :boolean,default: false
    add_column :neighborhoods, :delegates, :text
    add_column :neighborhoods, :urbanization_score, :float
  end
end