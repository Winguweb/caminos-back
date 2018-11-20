class AddVerificationToAssets < ActiveRecord::Migration[5.1]
  def change
    add_column :assets, :verification, :integer, :default => 0
    add_index  :assets, :verification
  end
end
