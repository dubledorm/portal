class Gallery < ApplicationRecord
  GALLERY_STATES = %w(active).freeze

  belongs_to :user
  validates :state, presence: true, inclusion: { in: GALLERY_STATES }
end
