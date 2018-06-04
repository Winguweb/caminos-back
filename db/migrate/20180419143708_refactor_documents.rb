class RefactorDocuments < ActiveRecord::Migration[5.1]
  def up
    drop_table :documents

    create_table :documents, id: :uuid do |t|
      t.string :type

      t.string :name
      t.string :description
      t.uuid :neighborhood_id, null: false, index: true

      t.string :attachment
      t.string :file_type
      t.integer :file_size

      t.jsonb :data, default: {}, null: false

      t.timestamps
    end
    add_index  :documents, :data, using: :gin

    create_table :documents_relations do |t|
      t.uuid :document_id, null: false, index: true

      t.string :relatable_type
      t.uuid :relatable_id, null: false

      t.uuid :responsible_id, null: false, index: true

      t.datetime :created_at
    end
    add_index :documents_relations, [:relatable_type, :relatable_id]
  end

  # I create this down method in order to be able to rollback the migration
  # without the need to specify all this in the drop_table method
  def down
    drop_table :documents
    drop_table :documents_relations

    create_table :documents, id: :uuid do |t|
      t.string :name
      t.string :description

      t.string :attachment_type
      t.string :attachment_source
      t.string :filetype

      t.string :holder_type
      t.uuid :holder_id, null: false, index: true

      t.timestamps
    end
    add_index :documents, [:holder_type, :holder_id]
  end
end
