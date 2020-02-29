class Tag < ApplicationRecord

  # Тэги используются для пометки объектов
  # Для этого используются тэги с типом ordinal
  # Также, тэгами могут быть реализованы другие группировки объектов
  # Например по категориям
  # В этом случае нужно использовать тэги с соответствующим типом (category)
  # Список типов должен расширяться в соответствии с требованиями
  #

  TAG_TYPES = %w(ordinal category)

  has_many :tags_on_objects, dependent: :destroy
  has_many :users, through: :tags_on_objects, source: :taggable, source_type: 'User'

  validates :name, :tag_type, presence: true
  validates :name, uniqueness: { scope: :tag_type }
  validates :tag_type, inclusion: { in: TAG_TYPES }

  scope :ordinal, ->{ where(tag_type: 'ordinal') }
end
