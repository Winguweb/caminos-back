class AddVerificationToClaims < ActiveRecord::Migration[5.1]
  def change
    add_column :claims, :verification, :integer, :default => 0
    add_index :claims, :verification
  end
end
