# encoding: UTF-8
module TaggableConcern
  extend ActiveSupport::Concern
  
  included do

    has_many :tags_on_objects, as: :taggable
    has_many :tags, through: :tags_on_objects

    def self.with_tags(tag_ids)
      joins(:tags_on_objects).where(tags_on_objects: { tag_id: tag_ids })
    end

  end  

  def tags_attributes=(params)
    tags.clear
    value = params[:titles]
    if value
      value.gsub(', ',',').split(',').each do |word|
        if (t = Tag.find_by_title(word)).blank?
          tags << Tag.create!(title: word, user_id: params[:user_id])
        else
          tags << t if !tags.include? t
        end
      end
    end
  end

  def tags_attributes
    tags.pluck(:title).join(', ')
  end

end
