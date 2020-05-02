class UserGalleryPresenter

  include ActiveModel::Model
#  include ActiveModel::Serializers::JSON

  attr_reader :h
  attr_accessor :id, :user_id, :name, :description, :state, :image_for_cover, :updated_at, :created_at
  validates :name, presence: true

  def initialize(context, attributes = {})
    # Следующие две строчки нужны только по тому, что мы вызываем initialize с доп параметром view_context
    # Если ьы параметром было только attributes = {}, то достаточно было бы просто super
    assign_attributes(attributes) if attributes
    super()

    @h = context
    @user_id = h.current_user.id if @user_id.nil?
    @state = :active if @state.nil?
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

  def create
    gallery = Gallery.new(attributes)

    unless valid?
      gallery.errors.merge!(self.errors)
      return gallery
    end

    gallery.save
    gallery
  end

  def update(gallery)
    unless valid?
      gallery.errors.merge!(self.errors)
      return gallery
    end

    gallery.update(attributes)
    gallery
  end
end