class AddAbbreviationToNeighborhood < ActiveRecord::Migration[5.1]
  def change
    add_column :neighborhoods, :abbreviation, :string
  end
end
