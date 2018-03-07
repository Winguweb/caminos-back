class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
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

    # doc = Document.create(name: 'Papeles barrio azul', description: 'Estos son los papeles del barrio azul', attachment_type: 'asset', attachment_source: 'http://lorempixel.com/400/200/cats', filetype: 'image/jpeg')

  end
end
