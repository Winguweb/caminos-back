class AddAncestryToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :ancestry, :string
    add_column :documents, :ancestry_depth, :integer, default: 0
    add_index :documents, :ancestry
  end
end
