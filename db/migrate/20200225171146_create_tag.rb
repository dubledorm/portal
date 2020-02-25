class CreateTag < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :tag_type, null: false
      t.string :name, null: false
      t.string :title

      t.timestamps
    end

    add_index :tags, :name
  end
end
