class UserGalleryPresenter

  include ActiveModel::Model
  include ActiveModel::Serializers::JSON

  attr_accessor :id, :user_id, :name, :description, :state, :image_for_cover
  validates :name, presence: true

  def initialize(attributes = {})
    super
  end

  def attributes
    {id: id,
     user_id: user_id,
     name: name,
     description: description,
     state: state,
     image_for_cover: image_for_cover
    }
  end

  def save(view_context)
    set_attributes(view_context)
    gallery = Gallery.new(attributes)

    unless valid?
      gallery.errors.merge!(self.errors)
      return gallery
    end

    gallery.save
    gallery
  end

  def set_attributes(view_context)
    @user_id = view_context.current_user.id if @user_id.nil?
    @state = :active if @state.nil?
  end
end