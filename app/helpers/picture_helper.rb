module PictureHelper

  def attached_image_tag(picture, options = {})
    image_tag picture.image, options  if picture.image.attached?
  end

  def gallery_link(picture)
    return '' if picture.gallery.nil?
    # "<a href=#{admin_gallery_path(picture.gallery)} target='_blank'>#{picture.gallery.name}</a>"
  end
end
