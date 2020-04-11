module PictureHelper

  def attached_image_tag(picture, options = {})
    image_tag picture.image, options  if picture.image.attached?
  end

  def cover_gallery_small(gallery)
    if gallery.image_for_cover.attached?
      background_image = url_for(gallery.image_for_cover.variant(resize_to_limit: [600, 600]))
    else
      background_image = asset_path('images/sidebar-g-1.png')
    end
    content_tag(:div, class: :cover_gallery_small, style: "background-image: url('#{ background_image }');" ) {}
  end

  def cover_image(image)
    content_tag(:div, class: :cover_image, style: "background-image: url('#{ url_for(image.variant(resize_to_limit: [600, 600])) }');" ) {}
  end
end
