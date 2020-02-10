# encoding: UTF-8
module UserConcern
  extend ActiveSupport::Concern

  AVATAR_SIZE = { width: 100, height: 100 }.freeze

  def get_avatar
    self.avatar.variant(resize_to_limit: [AVATAR_SIZE[:width], AVATAR_SIZE[:height]])
  end
end
