class Tag < ApplicationRecord

  has_many :tags_on_objects, dependent: :destroy
  has_many :users, through: :tags_on_objects, source: :taggable, source_type: 'User'

  validates :name, :tag_type, presence: true
  validates :name, uniqueness: { scope: :tag_type }
end
