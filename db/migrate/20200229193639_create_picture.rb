class CreatePicture < ActiveRecord::Migration[6.0]
  def change
    create_table :pictures do |t|
      t.string :name
      t.string :description
      t.references :gallery, null: false, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end
