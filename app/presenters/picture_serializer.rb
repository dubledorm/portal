class PictureSerializer
  include ActiveModel::Serialization

  attr_accessor :id, :cover_image_url, :image_url, :name, :description

  def from_picture(picture)
    @id = picture.id
    @name = picture.name
    @description = picture.description
    @cover_image_url = picture.decorate.image_for_cover
    @image_url = picture.decorate.image
    self
  end

  def attributes
    {'id': id,
     'name': name,
     'description': description,
     'cover_image_url': cover_image_url,
     'image_url': image_url}
  end
end