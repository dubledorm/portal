class Blog < ApplicationRecord
  include TaggableConcern
  include HumanAttributeValue

  BLOG_TYPES = %w(event article news_article).freeze
  BLOG_STATES = %w(active deleted draft).freeze

  belongs_to :user
  belongs_to :gallery

  has_one_attached :main_image

  validates :post_type, :state, :title, presence: true
  validates :post_type, inclusion: { in: BLOG_TYPES }
  validates :state, inclusion: { in: BLOG_STATES }
end
