class Tag < ApplicationRecord

  # Тэги используются для пометки объектов
  # Для этого используются тэги с типом ordinal
  # Также, тэгами могут быть реализованы другие группировки объектов
  # Например по категориям
  # В этом случае нужно использовать тэги с соответствующим типом (category)
  # Список типов должен расширяться в соответствии с требованиями
  #
  # Атрибуты:
  # tag_type - тип, для разделения тэгов по назначению
  # name - название тэга. Короткое название используемое для поиска
  # title - Заголовок, который может быть использован если тэги используются для группировки объектов

  TAG_TYPES = %w(ordinal category).freeze

  has_many :tags_on_objects, dependent: :destroy
  has_many :users, through: :tags_on_objects, source: :taggable, source_type: 'User'
  has_many :blogs, through: :tags_on_objects, source: :taggable, source_type: 'Blog'

  validates :name, :tag_type, presence: true
  validates :name, uniqueness: { scope: :tag_type }
  validates :tag_type, inclusion: { in: TAG_TYPES }

  scope :ordinal, ->{ where(tag_type: 'ordinal') }
end
