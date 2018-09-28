class AddSlugToMeetings < ActiveRecord::Migration[5.1]
  def change
    add_column :meetings, :slug, :string
    add_index :meetings, :slug
  end
end
