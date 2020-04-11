module PictureHelper

  def attached_image_tag(picture, options = {})
    image_tag picture.image, options  if picture.image.attached?
  end

  def gallery_cover_small(gallery)
    if gallery.image_for_cover.attached?
      background_image = url_for(gallery.image_for_cover.variant(resize_to_limit: [600, 600]))
    else
      background_image = asset_path('images/sidebar-g-1.png')
    end
    content_tag(:div, class: :image_in_column_gallery, style: "background-image: url('#{ background_image }');" ) {}
  end
end
