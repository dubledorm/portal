class GalleryDecorator < Draper::Decorator
  delegate_all

  def image_for_cover
    image_wrapper(object.image_for_cover, [600, 600])
  end
end