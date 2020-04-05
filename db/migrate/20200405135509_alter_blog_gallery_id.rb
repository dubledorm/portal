class AlterBlogGalleryId < ActiveRecord::Migration[6.0]
  def change
    change_column :blogs, :gallery_id, :bigint, null: true
  end
end
