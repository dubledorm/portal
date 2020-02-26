class CreateTagsOnObject < ActiveRecord::Migration[6.0]
  def change
    create_table :tags_on_objects do |t|
      t.integer :tag_id, null: false
      t.integer :taggable_id, null: false
      t.string :taggable_type, null: false
    end

    add_index :tags_on_objects, [:taggable_id, :taggable_type, :tag_id], name: 'taggable_tag_id'
  end
end
