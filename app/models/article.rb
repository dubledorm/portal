class Article < ApplicationRecord
  include TaggableConcern
  include HumanAttributeValue

  ARTICLE_TYPES = %w(service product).freeze
  ARTICLE_STATES = %w(active deleted draft).freeze

  belongs_to :user
  belongs_to :gallery, optional: true # Может быть добавлнена галерея с картинками

  has_one_attached :main_image        # Может иметь одну основную картинку

  validates :article_type, :state, :name, presence: true
  validates :article_type, inclusion: { in: ARTICLE_TYPES }
  validates :state, inclusion: { in: ARTICLE_STATES }
  validates :min_quantity, :max_quantity, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :min_age, :max_age, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :duration_minutes, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  scope :by_article_type, ->(article_type){ where(article_type: article_type) }
  scope :by_state, ->(state){ where(state: state) }
  scope :by_user, ->(user){ where(user: user) }
  scope :greater_than_min_age, ->(min_age){ where('min_age <= ?', min_age) }
  scope :less_than_max_age, ->(max_age){ where('max_age >= ?', max_age) }
  scope :greater_than_min_quantity, ->(min_quantity){ where('min_quantity <= ?', min_quantity) }
  scope :less_than_max_quantity, ->(max_quantity){ where('max_quantity >= ?', max_quantity) }

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
