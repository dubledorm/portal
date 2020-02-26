# encoding: UTF-8
module TaggableConcern
  extend ActiveSupport::Concern
  
  included do

    has_many :tags_on_objects, as: :taggable
    has_many :tags, through: :tags_on_objects

    scope :by_tag, ->(tag_name){ joins(:tags).where(tags: { name: tag_name }) }
  end  

  def tags_attributes
    tags.pluck(:title).join(', ')
  end
end
