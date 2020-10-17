class GallerySerializer
  include ActiveModel::Serialization

  attr_accessor :name, :description, :pictures

  def from_gallery(gallery)
    @name = gallery.name
    @description = gallery.description
    @pictures = gallery.pictures.inject([]){ |result, picture| result << PictureSerializer.new.from_picture(picture).serializable_hash }
    self
  end

  def attributes
    { 'name': name,
      'description': description,
      'pictures': pictures }
  end
end