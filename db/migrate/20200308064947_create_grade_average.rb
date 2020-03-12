class CreateGradeAverage < ActiveRecord::Migration[6.0]
  def change
    create_table :grade_averages do |t|
      t.references :object, polymorphic: true
      t.integer :grade_value
      t.integer :grade_count
      t.string :grade_type, null: false

      t.timestamps
    end

    add_index :grade_averages, :grade_value
    add_index :grade_averages, :grade_type
  end
end
