include PictureHelper

ActiveAdmin.register Picture do
  menu parent: :resources
  permit_params :gallery_id, :name, :description, :image, :state

  index do
    selectable_column
    id_column
    column :gallery
    column :name
    column :state
    column :created_at
    actions
  end

  show do
    attributes_table do
      # row :gallery do |picture|
      #   gallery_link(picture).html_safe
      # end
      row :name
      row :description
      row :created_at
      row :updated_at
      row :state
      row :image do |picture|
        attached_image_tag(picture)
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :gallery
      f.input :name
      f.input :description
      f.input :state
      f.file_field :image
    end
    f.actions
  end
end
