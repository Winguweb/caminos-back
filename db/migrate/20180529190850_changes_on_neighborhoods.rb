class ChangesOnNeighborhoods < ActiveRecord::Migration[5.1]
  def change
    rename_column :neighborhoods, :delegates, :extras
    change_column :neighborhoods, :extras, 'jsonb USING CAST(extras AS jsonb)', default: {}
  end
end
