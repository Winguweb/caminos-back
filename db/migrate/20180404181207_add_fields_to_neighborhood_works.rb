class AddFieldsToNeighborhoodWorks < ActiveRecord::Migration[5.1]
  def change
    add_column :neighborhoods, :urbanization, :boolean,default: false
    add_column :neighborhoods, :delegates, :text
    add_column :neighborhoods, :urbanization_score, :float
    add_column :works, :company, :string
  end
end