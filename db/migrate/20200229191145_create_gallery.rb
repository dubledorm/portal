class CreateGallery < ActiveRecord::Migration[6.0]
  def change
    create_table :galleries do |t|
      t.references :user
      t.string :name
      t.string :description
      t.string :state, null: false

      t.timestamps
    end
  end
end
