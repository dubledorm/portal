class CreateBlog < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.string :post_type, null: false
      t.references :gallery, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :event_date
      t.boolean :seo_flag, default: false
      t.text :content
      t.string :title
      t.string :state, null: false
      t.string :seo_keywords
      t.string :description

      t.timestamps
    end

    add_index :blogs, :post_type
    add_index :blogs, :event_date
    add_index :blogs, :seo_flag
    add_index :blogs, :state
  end
end
