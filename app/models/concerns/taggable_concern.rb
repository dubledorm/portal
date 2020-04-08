# encoding: UTF-8
module TaggableConcern
  extend ActiveSupport::Concern

  # Концерн предоставляет возможность помечать объекты тэгами с типом ordinal
  # Подробнее про типы тэгов написано в tag.rb
  
  included do

    has_many :tags_on_objects, as: :taggable
    has_many :tags, through: :tags_on_objects

    scope :by_tag, ->(tag_name){ joins(:tags).where(tags: { name: tag_name, tag_type: 'ordinal' }) }
  end

  def ordinal_tags
    tags.ordinal
  end

  def tags_names
    tags.ordinal.pluck(:name).join(', ')
  end

  def tags_titles
    tags.ordinal.pluck(:title).join(', ')
  end

  def add_tag(tag_name, tag_title = nil)
    tag = Tag.ordinal.find_by_name(tag_name)
    if tag
      self.tags << tag
    else
      self.tags.create!(name: tag_name, tag_type: 'ordinal', title: tag_title)
    end
  end

  def delete_tag(tag_name)
    tag = self.tags.ordinal.find_by_name(tag_name)
    if tag
      self.tags.delete(tag)
      tag.destroy if tag.tags_on_objects.count == 0
    end
  end
end
