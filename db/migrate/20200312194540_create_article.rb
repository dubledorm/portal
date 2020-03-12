class CreateArticle < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :gallery, null: true, foreign_key: true
      t.text :main_description
      t.text :short_description
      t.string :state, null: false
      t.string :article_type, null: false
      t.integer :min_quantity
      t.integer :max_quantity
      t.integer :min_age
      t.integer :max_age
      t.string :seo_description
      t.string :seo_keywords
      t.integer :duration_minutes
      t.string :name, null: false

      t.timestamps
    end

    add_index :articles, :name
    add_index :articles, :article_type
    add_index :articles, :state
    add_index :articles, :min_age
    add_index :articles, :max_age
    add_index :articles, :min_quantity
    add_index :articles, :max_quantity
  end
end
