class PictureDecorator < Draper::Decorator
  delegate_all

  def image_for_cover
    image_wrapper(object.image, [600, 600])
  end

  def image
    image_wrapper(object.image, [1200, 1200])
  end
end