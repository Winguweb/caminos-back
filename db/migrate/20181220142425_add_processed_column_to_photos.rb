class AddProcessedColumnToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :processed, :boolean
  end
end
