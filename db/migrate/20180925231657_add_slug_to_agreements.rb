class AddSlugToAgreements < ActiveRecord::Migration[5.1]
  def change
    add_column :agreements, :slug, :string
    add_index :agreements, :slug
  end
end
