class AddNameAndStatusToWorks < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :name, :string
    add_column :works, :status, :string
  end
end
