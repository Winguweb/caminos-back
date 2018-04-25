class AddActsAsTaggable < ActiveRecord::Migration[5.1]
  def change
    drop_table :taggings if table_exists?(:taggings)
    drop_table :tags if table_exists?(:tags)

    create_table :taggings do |t|
      t.integer :tag_id

      t.string :taggable_type
      t.uuid :taggable_id

      t.string :tagger_type
      t.uuid :tagger_id

      t.string :context

      t.datetime :created_at

      t.index [:context]
      t.index [:tag_id, :taggable_id, :taggable_type, :context, :tagger_id, :tagger_type], name: "taggings_idx", unique: true
      t.index [:tag_id]
      t.index [:taggable_id, :taggable_type, :context]
      t.index [:taggable_id, :taggable_type, :tagger_id, :context], name: "taggings_idy"
      t.index [:taggable_id]
      t.index [:taggable_type]
      t.index [:tagger_id, :tagger_type]
      t.index [:tagger_id]
    end

    create_table "tags" do |t|
      t.string :name
      t.integer :taggings_count, default: 0
      t.index [:name], unique: true
    end
  end
end
