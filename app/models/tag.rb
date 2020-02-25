class Tag < ApplicationRecord

  validates :name, :tag_type, presence: true
  validates :name, uniqueness: { scope: :tag_type }
end
