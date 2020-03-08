class CreateGrade < ActiveRecord::Migration[6.0]
  def change
    create_table :grades do |t|
      t.references :user, null: false, foreign_key: true
      t.references :object, polymorphic: true
      t.text :content
      t.integer :grade_value
      t.string :grade_type, null: false
    end

    add_index :grades, :grade_value
    add_index :grades, :grade_type
  end
end
