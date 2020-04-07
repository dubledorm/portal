class Service < ApplicationRecord
  belongs_to :user

  scope :by_provider, ->(provider){ where(provider: provider) }
end
