class TagsOnObject < ActiveRecord::Base
  belongs_to :tag, counter_cache: :objects_count
  belongs_to :taggable, polymorphic: true
end
