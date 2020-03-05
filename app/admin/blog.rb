ActiveAdmin.register Blog do
  menu parent: :resources
  permit_params :post_type, :event_date, :user_id, :content, :title,
                :main_image, :seo_keywords, :gallery_id, :state, :description, :seo_flag

  index do
    selectable_column
    id_column
    column :post_type do |blog|
      blog.human_attribute_value(:post_type)
    end
    column :event_date
    column :title
    column :tags_titles
    column :seo_flag
    column :state do |blog|
      blog.human_attribute_value(:state)
    end
    column :main_image
    column :created_at
    actions
  end


  form do |f|
    f.inputs do
      f.input :post_type, :collection=>Blog::BLOG_TYPES.map{|elem| [Blog.human_attribute_value(:post_type, elem),elem]}
      f.input :gallery
      f.input :event_date
      f.input :title
      f.input :content
      f.input :user
      f.input :seo_flag
      f.input :seo_keywords
      f.input :description
      f.input :state, :collection=>Blog::BLOG_STATES.map{|elem| [Blog.human_attribute_value(:state, elem),elem]}
      f.file_field :main_image
    end
    f.actions
  end

    show do
      attributes_table do
        row :post_type do |blog|
          blog.human_attribute_value(:post_type)
        end
        row :event_date
        row :staff
        row :content do |blog|
          simple_format(blog.content)
        end
        row :title
        row :state do |blog|
          blog.human_attribute_value(:state)
        end
        row :tags_titles
        row :seo_flag
        row :seo_keywords
        row :description
        row :main_image do |blog|
          image_tag blog.main_image
        end
        row :gallery do |blog|
          if blog.gallery
            div do
              render 'admin/picture_gallery_show', gallery: blog.gallery, back: admin_blog_path(id: blog.id)
            end
          end
        end

      end
      active_admin_comments
    end
end
