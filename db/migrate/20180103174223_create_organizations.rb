class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations, id: :uuid do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
