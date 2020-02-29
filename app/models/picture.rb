class Picture < ApplicationRecord
  PICTURE_STATES = %w(active).freeze

  belongs_to :gallery
  has_one :user, through: :gallery
  validates :state, presence: true, inclusion: { in: PICTURE_STATES }
end
