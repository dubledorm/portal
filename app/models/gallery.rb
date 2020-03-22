class Gallery < ApplicationRecord
  GALLERY_STATES = %w(active).freeze

  belongs_to :user
  has_many :pictures, dependent: :destroy
  validates :state, presence: true, inclusion: { in: GALLERY_STATES }
end
