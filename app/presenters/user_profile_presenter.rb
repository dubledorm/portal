class UserProfilePresenter
  include ActiveModel::Serializers::JSON

  attr_reader :h
  attr_accessor :nick_name, :avatar

  def initialize(user, context)
    @h = context
    @nick_name = user.nick_name
    @avatar = image_path(user)
  end

  def attributes
    { nick_name: nick_name,
      avatar: avatar
    }
  end

  private
    def image_path(user)
      user.avatar.attached? ? h.url_for(user.avatar.variant(resize_to_limit: [200, 200])) : ''
    end
end