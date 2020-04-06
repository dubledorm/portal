class AddNickNameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :nick_name, :string

    add_index :users, :nick_name
  end
end
