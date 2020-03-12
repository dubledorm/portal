require 'rails_helper'

describe Article do
  describe 'factory' do
    let!(:article) {FactoryGirl.create :article}

    # Factories
    it { expect(article).to be_valid }

    # Relationships
    it { should belong_to(:gallery) }
    it { should belong_to(:user) }
    it { should have_many(:tags)}


    # Validations
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:article_type) }
  end
end