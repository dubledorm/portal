class Article < ApplicationRecord
  include TaggableConcern
  include HumanAttributeValue

  ARTICLE_TYPES = %w(service product).freeze
  ARTICLE_STATES = %w(active deleted draft).freeze

  belongs_to :user
  belongs_to :gallery, optional: true

  has_one_attached :main_image

  validates :article_type, :state, :name, presence: true
  validates :article_type, inclusion: { in: ARTICLE_TYPES }
  validates :state, inclusion: { in: ARTICLE_STATES }
  validates :min_quantity, :max_quantity, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :min_age, :max_age, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :duration_minutes, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true



  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  mappings do
    indexes :name,  type: 'text', analyzer: 'russian'
    indexes :main_description, type: 'text', analyzer: 'russian'
    indexes :short_description, type: 'text', analyzer: 'russian'
  end

  def self.search(query)
    __elasticsearch__.search(
        {
            query: {
                multi_match: {
                    query: query,
                    fields: ['name', 'main_description', 'short_description']
                }
            }
        }
    )
  end
end
