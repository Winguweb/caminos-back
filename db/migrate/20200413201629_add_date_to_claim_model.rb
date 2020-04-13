class AddDateToClaimModel < ActiveRecord::Migration[5.1]
  def change
    add_column :claims, :date, :datetime
  end
end
