class UserGalleryPresenter

  include ActiveModel::Model

  # Выполняет создание и обновление gallery
  # Выполняет проверки и предоставляет список ошибок


  attr_accessor :id, :user_id, :name, :description, :state, :image_for_cover, :updated_at, :created_at
  validates :name, presence: true, allow_nil: true

  def errors_to_json
    errors.full_messages.join(', ')
  end

  def attributes
    {'id': id,
     'user_id': user_id,
     'name': name,
     'description': description,
     'state': state,
     'image_for_cover': image_for_cover
    }
  end

  def create(context)
    set_attributes(context)
    gallery = Gallery.new(attributes)

    if make_validation?(gallery)
      ActiveRecord::Base.transaction do
        gallery.save
      end

      self.errors.merge!(gallery.errors)
    end
    gallery
  end

  def update(gallery, context)
    set_attributes(context)

    if make_validation?(gallery)
      ActiveRecord::Base.transaction do
        gallery.update(attributes_compact)
      end

      self.errors.merge!(gallery.errors)
    end
    gallery
  end

  private

  def set_attributes(context)
    @user_id = context.current_user.id if @user_id.nil?
    @state = :active if @state.nil?
  end

  def attributes_compact
    Hash[*attributes.find_all{ |key, value| !value.nil?}.flatten]
  end

  def make_validation?(gallery)
    unless valid?
      gallery.errors.merge!(self.errors)
      return false
    end
    true
  end
end